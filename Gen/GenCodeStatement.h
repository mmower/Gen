//
//  GenCodeStatement.h
//  Gen
//
//  Created by Matt Mower on 31/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GenStatement.h"

@interface GenCodeStatement : GenStatement

@property (strong) NSString *body;

- (id)initWithBody:(NSString *)body;

@end
