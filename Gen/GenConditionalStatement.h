//
//  GenConditionalStatement.h
//  Gen
//
//  Created by Matt Mower on 31/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GenStatement.h"

@interface GenConditionalStatement : GenStatement

@property (strong) NSString *condition;
@property (strong) GenStatement *ifTrue;
@property (strong) GenStatement *ifFalse;

- (id)initWithCondition:(NSString *)condition;

@end
