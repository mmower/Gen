//
//  GenTypedef.m
//  Gen
//
//  Created by Matt Mower on 31/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import "GenTypedef.h"

@implementation GenTypedef

@synthesize name = _name;
@synthesize type = _type;

- (id)initWithName:(NSString *)name type:(GenType *)type {
  self = [self init];
  if( self ) {
    _name = name;
    _type = type;
  }
  return self;
}


- (NSString *)statementString {
  NSMutableString *content = [NSMutableString string];
  [content appendFormat:@"typedef %@ %@;\n",[[self type] statementString],[self name]];
  return content;
}


@end
