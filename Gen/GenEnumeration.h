//
//  GenEnumeration.h
//  Gen
//
//  Created by Matt Mower on 31/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GenType.h"

@interface GenEnumeration : GenType {
  NSMutableArray *_elements;
}

- (void)addElement:(NSString *)element;

@end
