//
//  GenProperty.m
//  Gen
//
//  Created by Matt Mower on 30/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import "GenProperty.h"

/**
* Instances of GenProperty represent an Objective-C @property that can be added to a class.
*/

@implementation GenProperty

@synthesize attributes = _attributes;
@synthesize scope = _scope;
@synthesize type = _type;
@synthesize name = _name;

- (id)initWithTag:(NSString *)tag type:(NSString *)type name:(NSString *)name attributes:(GenPropertyAttribute)attributes {
  self = [super initWithTag:tag];
  if( self ) {
    _type = type;
    _name = name;
    _attributes = attributes;
  }
  return self;
}


- (id)initWithTag:(NSString *)tag type:(NSString *)type name:(NSString *)name {
  return [self initWithTag:tag type:type name:name attributes:GenPropertyStrong];
}


- (id)initWithType:(NSString *)type name:(NSString *)name {
  return [self initWithTag:nil type:type name:name attributes:GenPropertyStrong];
}


- (id)initWithType:(NSString *)type name:(NSString *)name attributes:(GenPropertyAttribute)attributes {
  return [self initWithTag:nil type:type name:name attributes:attributes];
}


- (BOOL)isPrivateScope {
  return ( _scope & GenPrivateScope) == GenPrivateScope;
}


- (BOOL)isPublicScope {
  return ![self isPrivateScope];
}


- (NSString *)attributesString {
  NSMutableArray *attributes = [NSMutableArray array];

  if( [self attributes] & GenPropertyAssign ) {
    [attributes addObject:@"assign"];
  }
  if( [self attributes] & GenPropertyCopy ) {
    [attributes addObject:@"copy"];
  }
  if( [self attributes] & GenPropertyNonatomic ) {
    [attributes addObject:@"nonatomic"];
  }
  if( [self attributes] & GenPropertyReadonly ) {
    [attributes addObject:@"readonly"];
  }
  if( [self attributes] & GenPropertyReadwrite ) {
    [attributes addObject:@"readwrite"];
  }
  if( [self attributes] & GenPropertyRetain ) {
    [attributes addObject:@"retain"];
  }
  if( [self attributes] & GenPropertyStrong ) {
    [attributes addObject:@"strong"];
  }
  if( [self attributes] & GenPropertyWeak ) {
    [attributes addObject:@"weak"];
  }

  return [attributes componentsJoinedByString:@","];
}


- (NSString *)declarationString {
  return [NSString stringWithFormat:@"@property (%@) %@ %@;\n", [self attributesString], [self type], [self name]];
}


- (NSString *)definitionString {
  return [NSString stringWithFormat:@"@synthesize %@ = %@;\n", [self name], [self backingInstanceVariable]];
}


- (NSString *)backingInstanceVariable {
  return [NSString stringWithFormat:@"_%@",[self name]];
}


@end
