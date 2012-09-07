//
//  GenType.m
//  Gen
//
//  Created by Matt Mower on 31/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import "GenType.h"

@implementation GenType

@synthesize name = _name;

- (id)initWithName:(NSString *)name {
  self = [self init];
  if( self ) {
    _name = name;
  }
  return self;
}


- (NSString *)statementString {
  return @"";
}

@end
