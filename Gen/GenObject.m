//
//  GenObject.m
//  Gen
//
//  Created by Matt Mower on 30/07/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//


#import "GenObject.h"

/**
* GenObject is used as the base class for some of the other Gen object types and provides a simple tagging
* facility. In this sense GenObject does not refer to objects in the Objective-C sense but to objects implementing
* the Gen types.
*
* For example GenMethod inherits from GenObject and can, therefore, have a tag. While a method could
* be looked up via its selector it's often easier to tag methods you are interested in with simpler names.
*/


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
