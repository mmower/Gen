//
//  SFInstanceVariable.h
//  Gen
//
//  Created by Matt Mower on 30/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gen.h"

@interface GenVariable : GenObject {
}


@property (assign) GenScope scope;
@property (strong) NSString *type;
@property (strong) NSString *name;

- (id)initWithTag:(NSString *)tag scope:(GenScope)scope name:(NSString *)name type:(NSString *)type;
- (id)initWithScope:(GenScope)scope name:(NSString *)name type:(NSString *)type;

- (BOOL)isInstanceScope;
- (BOOL)isGlobalScope;
- (BOOL)isStaticScope;
- (BOOL)isPublicScope;
- (BOOL)isPrivateScope;

- (NSString *)declarationString;
- (NSString *)definitionString;

@end
