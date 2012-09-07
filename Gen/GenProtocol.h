//
//  GenProtocol.h
//  CSM
//
//  Created by Matt Mower on 28/07/2012.
//  Copyright (c) 2012 Smartfish Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GenObject.h"

@class GenMethod;

@interface GenProtocol : GenObject

@property (strong) NSString *name;
@property (strong) GenProtocol *baseProtocol;
@property (strong) NSMutableArray *methods;

- (id)initWithTag:(NSString *)tag name:(NSString *)name baseProtocol:(GenProtocol *)baseProtocol;
- (id)initWithName:(NSString *)name baseProtocol:(GenProtocol *)baseProtocol;

- (void)addMethod:(GenMethod *)method;

- (NSString *)type;

- (NSString *)declarationsString;

@end
