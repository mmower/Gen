//
//  SFClassMethod.h
//  Gen
//
//  Created by Matt Mower on 30/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gen.h"

@class GenArgument;
@class GenStatementGroup;

@interface GenMethod : GenObject <NSMutableCopying>

@property (assign) GenScope scope;
@property (strong) NSString *returnType;
@property (assign) SEL selector;
@property (strong) GenStatementGroup *body;
@property (strong) NSMutableArray *arguments;
@property (assign) BOOL isDeclaredHere;

- (id)initWithTag:(NSString *)tag scope:(GenScope)scope returnType:(NSString *)returnType selector:(SEL)selector;
- (id)initWithTag:(NSString *)tag scope:(GenScope)scope returnType:(NSString *)returnType selectorFormat:(NSString *)format, ...;

- (id)initWithScope:(GenScope)scope returnType:(NSString *)returnType selector:(SEL)selector;
- (id)initWithScope:(GenScope)scope returnType:(NSString *)returnType selectorFormat:(NSString *)format, ...;

- (void)addArgument:(GenArgument *)argument;

- (BOOL)isInstanceScope;
- (BOOL)isClassScope;
- (BOOL)isPrivateScope;
- (BOOL)isPublicScope;


- (NSString *)declarationString;
- (NSString *)definitionString;

- (NSString *)invocationWithReceiver:(NSString *)receiver;

- (NSUInteger)argumentCount;
@end
