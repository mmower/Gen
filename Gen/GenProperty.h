//
//  SFPropertyModel.h
//  Gen
//
//  Created by Matt Mower on 30/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GenObject.h"
#import "Gen.h"

typedef enum {
  GenPropertyReadwrite = 1,
  GenPropertyReadonly = 2,
  GenPropertyStrong = 4,
  GenPropertyWeak = 8,
  GenPropertyCopy = 16,
  GenPropertyAssign = 32,
  GenPropertyRetain = 64,
  GenPropertyNonatomic = 128
} GenPropertyAttribute;

@interface GenProperty : GenObject

@property (assign) GenScope scope;

@property (assign) GenPropertyAttribute attributes;

@property (strong) NSString *type;
@property (strong) NSString *name;

- (id)initWithTag:(NSString *)tag type:(NSString *)type name:(NSString *)name;
- (id)initWithTag:(NSString *)tag type:(NSString *)type name:(NSString *)name attributes:(GenPropertyAttribute)attributes;
- (id)initWithType:(NSString *)type name:(NSString *)name;
- (id)initWithType:(NSString *)type name:(NSString *)name attributes:(GenPropertyAttribute)attributes;

- (BOOL)isPrivateScope;
- (BOOL)isPublicScope;

- (NSString *)declarationString;
- (NSString *)definitionString;

- (NSString *)backingInstanceVariable;


@end
