//
//  GenCompilationUnit.h
//  Gen
//
//  Created by Matt Mower on 31/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GenObject.h"

@class GenType;
@class GenClass;
@class GenVariable;
@class GenProtocol;

@interface GenCompilationUnit : GenObject

@property (strong) NSString *name;
@property (strong) NSString *comment;
@property (strong) NSMutableArray *declarationImports;
@property (strong) NSMutableArray *definitionImports;
@property (strong) NSMutableArray *forwardDeclarations;
@property (strong) NSMutableArray *variables;
@property (strong) NSMutableArray *types;
@property (strong) NSMutableArray *classes;
@property (strong) NSMutableArray *protocols;
@property (strong) GenClass *principalClass;

- (id)initWithTag:(NSString *)tag name:(NSString *)name;
- (id)initWithName:(NSString *)name;

- (void)addDeclarationImport:(NSString *)import;
- (void)addDefinitionImport:(NSString *)import;
- (void)addForwardDeclaration:(NSString *)klass;
- (void)addVariable:(GenVariable *)variable;
- (void)addClass:(GenClass *)klass;
- (void)addProtocol:(GenProtocol *)protocol;
- (void)addType:(GenType *)type;

- (NSString *)headerFileName;
- (NSString *)classFileName;

- (BOOL)writeDefinitions:(NSString *)path error:(NSError **)error;
- (BOOL)writeDeclarations:(NSString *)path error:(NSError **)error;
- (BOOL)writeFilesTo:(NSString *)folder error:(NSError **)error;

- (GenProtocol *)protocolWithTag:(NSString *)tag;
- (GenClass *)classWithTag:(NSString *)tag;
@end
