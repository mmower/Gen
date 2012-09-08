//
//  GenProtocol.m
//  CSM
//
//  Created by Matt Mower on 28/07/2012.
//  Copyright (c) 2012 Smartfish Software Ltd. All rights reserved.
//

#import "GenProtocol.h"

#import "GenMethod.h"

/**
* Instances of GenProtocol represent an Objective-C protocol that a class can be made to conform to. Much like
* a GenClass can have a base class a GenProtocol can have a base protocol.
*
* Instances of GenMethod can be added to the protocol using -addMethod: and, in this case, they may have no body
* and if they do the body will be ignored.
*
* @warning much as with the baseClass issue with GenClass the baseProtocol for GenProtocol may be too inflexible for
* general use.
*/

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
