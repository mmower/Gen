//
//  GenObject.m
//  Gen
//
//  Created by Matt Mower on 30/07/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//


#import "GenObject.h"


@implementation GenObject {

}

@synthesize tag = _tag;

- (id)initWithTag:(NSString *)tag {
  self = [self init];
  if( self ) {
    _tag = tag;
  }
  return self;
}


@end
