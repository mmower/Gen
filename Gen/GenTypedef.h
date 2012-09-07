//
//  GenTypedef.h
//  Gen
//
//  Created by Matt Mower on 31/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GenType.h"

@interface GenTypedef : GenType

@property (strong) NSString *name;
@property (strong) GenType *type;

- (id)initWithName:(NSString *)name type:(GenType *)type;

@end
