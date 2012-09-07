//
//  GenCodeStatement.m
//  Gen
//
//  Created by Matt Mower on 31/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import "GenCodeStatement.h"

@implementation GenCodeStatement

@synthesize body = _body;

- (id)initWithBody:(NSString *)body {
  self = [self init];
  if( self ) {
    _body = body;
  }
  return self;
}

- (NSString *)statementString {
  return [NSString stringWithFormat:@"%@;",[self body]];
}

@end
