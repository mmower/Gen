//
//  GenVariable.m
//  Gen
//
//  Created by Matt Mower on 30/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import "GenVariable.h"

@implementation GenVariable

@synthesize scope = _scope;
@synthesize name = _name;
@synthesize type = _type;

- (id)initWithTag:(NSString *)tag scope:(GenScope)scope name:(NSString *)name type:(NSString *)type {
  self = [self initWithTag:tag];
  if( self ) {
    _scope = scope;
    _name = name;
    _type = type;
  }
  return self;
}


- (id)initWithScope:(GenScope)scope name:(NSString *)name type:(NSString *)type {
  return [self initWithTag:nil scope:scope name:name type:type];
}


- (BOOL)isInstanceScope {
  return ( _scope & GenInstanceScope) == GenInstanceScope;
}


- (BOOL)isGlobalScope {
  return ( _scope & GenGlobalScope) == GenGlobalScope;
}


- (BOOL)isStaticScope {
  return ( _scope & GenStaticScope) == GenStaticScope;
}


- (BOOL)isPrivateScope {
  return ( _scope & GenPrivateScope) == GenPrivateScope;
}


- (BOOL)isPublicScope {
  return ![self isPrivateScope];
}


- (NSString *)declarationString {
  if( [self isInstanceScope] ) {
    return [NSString stringWithFormat:@"\t%@ %@;\n", [self type], [self name]];
  } else {
    if( !(_scope & GenStaticScope) ) {
      return [NSString stringWithFormat:@"extern %@ %@;", [self type], [self name]];
    } else {
      return @"";
    }
  }
}


- (NSString *)definitionString {
  if( [self isGlobalScope] ) {
    if( _scope & GenStaticScope ) {
      return [NSString stringWithFormat:@"static %@ %@;\n", [self type], [self name]];
    } else {
      return [NSString stringWithFormat:@"%@ %@;\n", [self type], [self name]];
    }
  } else {
    return @"";
  }
}


@end
