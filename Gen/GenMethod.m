//
//  GenMethod.m
//  Gen
//
//  Created by Matt Mower on 30/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import "GenMethod.h"

@implementation GenMethod

@synthesize scope = _scope;
@synthesize returnType = _returnType;
@synthesize selector = _selector;
@synthesize body = _body;
@synthesize arguments = _arguments;
@synthesize isDeclaredHere = _isDeclaredHere;


- (id)initWithTag:(NSString *)tag scope:(GenScope)scope returnType:(NSString *)returnType selector:(SEL)selector {
  self = [self initWithTag:tag];
  if( self ) {
    _scope = scope;
    _returnType = returnType;
    _selector = selector;
    _arguments = [NSMutableArray array];
    _body = [GenStatementGroup group];
    _isDeclaredHere = YES;
  }
  return self;
}


- (id)initWithTag:(NSString *)tag scope:(GenScope)scope returnType:(NSString *)returnType selectorFormat:(NSString *)format, ... {
  va_list args;
  va_start( args, format );
  NSString *selectorString = [[NSString alloc] initWithFormat:format arguments:args];
  va_end( args );
  return [self initWithTag:tag scope:scope returnType:returnType selector:NSSelectorFromString(selectorString)];
}


- (id)initWithScope:(GenScope)scope returnType:(NSString *)returnType selector:(SEL)selector {
  return [self initWithTag:nil scope:scope returnType:returnType selector:selector];
}


- (id)initWithScope:(GenScope)scope returnType:(NSString *)returnType selectorFormat:(NSString *)format, ... {
  va_list args;
  va_start( args, format );
  NSString *selectorString = [[NSString alloc] initWithFormat:format arguments:args];
  va_end( args );
  return [self initWithTag:nil scope:scope returnType:returnType selector:NSSelectorFromString(selectorString)];
}


- (void)addArgument:(GenArgument *)argument {
  [[self arguments] addObject:argument];
}


- (BOOL)isInstanceScope {
  return (GenInstanceScope & _scope) == GenInstanceScope;
}


- (BOOL)isClassScope {
  return (GenClassScope & _scope) == GenClassScope;
}


- (BOOL)isPrivateScope {
  return (GenPrivateScope & _scope) == GenPrivateScope;
}


- (BOOL)isPublicScope {
  return ![self isPrivateScope];
}


- (NSString *)scopeString {
  if( [self isInstanceScope] ) {
    return @"-";
  } else {
    return @"+";
  }
}


- (NSString *)selectorString {
  return NSStringFromSelector([self selector]);
}


- (NSString *)signatuareString {
  NSMutableString *content = [NSMutableString string];

  [content appendString:[self scopeString]];
  [content appendString:@" ("];
  [content appendString:[self returnType]];
  [content appendString:@")"];

  NSRange range = [[self selectorString] rangeOfString:@":"];
  if( range.location == NSNotFound ) {
    [content appendString:[self selectorString]];
  } else {

    NSArray *selectorComponents = [[self selectorString] componentsSeparatedByString:@":"];
    if( [[selectorComponents objectAtIndex:[selectorComponents count] - 1] isEqualToString:@""] ) {
      selectorComponents = [selectorComponents subarrayWithRange:NSMakeRange(0, [selectorComponents count] - 1)];
    }

    if( [[self arguments] count] < [selectorComponents count] ) {
      NSLog(@"Method has less arguments than selector components");
      return content;
    }

    int componentIndex = 0;
    for( NSString *component in selectorComponents ) {
      if( componentIndex > 0 ) {
        [content appendString:@" "];
      }

      [content appendFormat:@"%@:%@", component, [[[self arguments] objectAtIndex:componentIndex] argumentString]];

      componentIndex += 1;
    }
  }

  return content;
}


- (NSString *)declarationString {
  return [NSString stringWithFormat:@"%@;\n", [self signatuareString]];
}


- (NSString *)definitionString {
  return [NSString stringWithFormat:@"%@ %@\n", [self signatuareString], [[self body] statementString]];
}


- (id)mutableCopyWithZone:(NSZone *)zone {
  GenMethod *copy = [[GenMethod allocWithZone:zone] initWithTag:[self tag]
                                                                scope:[self scope]
                                                           returnType:[self returnType]
                                                             selector:[self selector]];

  for( GenArgument *argument in [self arguments] ) {
    [copy addArgument:argument];
  }

  if( [self body] ) {
    [copy setBody:[self body]];
  }

  return copy;
}


- (NSString *)invocationWithReceiver:(NSString *)receiver {
  return [NSString stringWithFormat:@"[%@ %@]", receiver, [self selectorString]];
}

- (NSUInteger)argumentCount {
  return [[self arguments] count];
}

@end
