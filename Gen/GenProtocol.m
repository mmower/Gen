//
//  GenProtocol.m
//  CSM
//
//  Created by Matt Mower on 28/07/2012.
//  Copyright (c) 2012 Smartfish Software Ltd. All rights reserved.
//

#import "GenProtocol.h"

#import "GenMethod.h"

@implementation GenProtocol

@synthesize name = _name;
@synthesize baseProtocol = _baseProtocol;
@synthesize methods = _methods;

- (id)initWithTag:(NSString *)tag name:(NSString *)name baseProtocol:(GenProtocol *)baseProtocol {
  self = [self initWithTag:tag];
  if( self ) {
    _name = name;
    _baseProtocol = baseProtocol;
    _methods = [NSMutableArray array];
  }
  return self;
}


- (id)initWithName:(NSString *)name baseProtocol:(GenProtocol *)baseProtocol {
  return [self initWithTag:nil name:name baseProtocol:baseProtocol];
}


- (NSString *)type {
  return [NSString stringWithFormat:@"id<%@>",[self name]];
}


- (void)addMethod:(GenMethod *)method {
  if( !([method scope] == GenInstanceScope) ) {
    [NSException raise:@"ScopeException" format:@"Cannot add methods to protocols with other than instance scope!"];
  }

  [_methods addObject:method];
}


- (NSString *)methodsDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self methods] ) {
    [content appendString:[method declarationString]];
  }

  return content;
}


- (NSString *)declarationsString {
  NSMutableString *content = [NSMutableString string];

  if( [self baseProtocol] ) {
    [content appendFormat:@"@protocol %@ : %@\n", [self name], [[self baseProtocol] name]];
  } else {
    [content appendFormat:@"@protocol %@\n", [self name]];
  }
  [content appendFormat:@"%@\n", [self methodsDeclarationString]];
  [content appendString:@"@end\n\n\n"];

  return content;

}


@end
