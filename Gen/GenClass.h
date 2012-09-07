//
//  GenClass.h
//  Gen
//
//  Created by Matt Mower on 30/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GenObject.h"

@class GenMethod;
@class GenVariable;
@class GenProperty;
@class GenProtocol;

@interface GenClass : GenObject

@property (strong) NSString *name;
@property (strong) GenClass *baseClass;

@property (strong) NSMutableArray  *protocols;

@property (strong) NSMutableArray *initializers;
@property (strong) NSMutableArray *properties;
@property (strong) NSMutableArray *variables;
@property (strong) NSMutableArray *classMethods;
@property (strong) NSMutableArray *instanceMethods;

@property (strong) NSMutableArray *classDeclarations;

- (id)initWithTag:(NSString *)tag name:(NSString *)name baseClass:(GenClass *)baseClass;
- (id)initWithName:(NSString *)name baseClass:(GenClass *)baseClass;
- (id)initWithTag:(NSString *)tag name:(NSString *)name;
- (id)initWithName:(NSString *)name;

- (void)addProtocol:(GenProtocol *)protocol;
- (void)addVariable:(GenVariable *)variable;
- (void)addProperty:(GenProperty *)property;
- (void)addInitializer:(GenMethod *)method;
- (void)addMethod:(GenMethod *)method;
- (void)addMethods:(NSArray *)methods;

- (NSString *)publicDeclarationString;
- (NSString *)privateDeclarationString;
- (NSString *)definitionString;

- (NSString *)pointerType;

- (GenMethod *)instanceMethodWithTag:(NSString *)tag;
@end
