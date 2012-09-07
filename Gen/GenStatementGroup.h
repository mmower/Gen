//
//  GenStatementGroup.h
//  Gen
//
//  Created by Matt Mower on 31/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GenStatement.h"

@interface GenStatementGroup : GenStatement

@property (strong) NSMutableArray *statements;

+ (GenStatementGroup *)group;

- (id)initWithBody:(NSString *)body;
- (id)initWithFormat:(NSString *)format, ...;
//- (id)initWithStatement:(GenStatement *)statement;

- (void)append:(NSString *)format, ...;
- (void)addStatement:(GenStatement *)statement;

@end
