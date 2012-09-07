//
//  GenStatementGroup.m
//  Gen
//
//  Created by Matt Mower on 31/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import "GenStatementGroup.h"

#import "Gen.h"

@implementation GenStatementGroup

@synthesize statements = _statements;


+ (GenStatementGroup *)group {
  return [[GenStatementGroup alloc] init];
}

- (id)init {
  self = [super init];
  if( self ) {
    _statements = [[NSMutableArray alloc] init];
  }
  return self;
}


- (id)initWithBody:(NSString *)body {
  self = [self init];
  if( self ) {
    [self append:body];
//    [self addStatement:[[GenCodeStatement alloc] initWithBody:body]];
  }
  return self;
}


- (id)initWithFormat:(NSString *)format, ... {
  va_list args;
  va_start( args, format );
  NSString *body = (__bridge_transfer NSString *)CFStringCreateWithFormatAndArguments(kCFAllocatorDefault, NULL, (__bridge CFStringRef)format, args );
  va_end( args );
  return [self initWithBody:body];
}


//- (id)initWithStatement:(GenStatement *)statement {
//  self = [self init];
//  if( self ) {
//    [self addStatement:statement];
//  }
//  return self;
//}


- (void)append:(NSString *)format, ... {
  va_list args;
  va_start( args, format );
  NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:args];
  va_end( args );
  [[self statements] addObject:formattedString];
}


//- (void)addLine:(NSString *)line {
//  [[self statements] addObject:line];
//}


- (void)addStatement:(GenStatement *)statement {
  [[self statements] addObject:statement];
}


- (NSString *)statementString {
  NSMutableString *content = [NSMutableString string];
  
  [content appendString:@"{\n"];
  for( id statement in [self statements] ) {
    if( [statement isKindOfClass:[GenStatement class]] ) {
      [content appendString:[statement statementString]];
    } else {
      [content appendFormat:@"%@\n",statement];
    }
  }
  [content appendString:@"}\n"];
  
  return content;
}


@end
