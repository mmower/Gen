//
//  GenArgument.m
//  Gen
//
//  Created by Matt Mower on 30/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import "GenArgument.h"

@implementation GenArgument

@synthesize type = _type;
@synthesize name = _name;

- (id)initWithType:(NSString *)type name:(NSString *)name {
  self = [super init];
  if( self ) {
    _type = type;
    _name = name;
  }
  return self;
}


- (NSString *)argumentString {
  return [NSString stringWithFormat:@"(%@)%@", [self type], [self name]];
}

@end
