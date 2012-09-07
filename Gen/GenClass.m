//
//  GenClass.m
//  Gen
//
//  Created by Matt Mower on 30/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import "GenClass.h"

#import "GenMethod.h"

@interface GenClass ()

@end


@implementation GenClass

@synthesize name = _name;
@synthesize baseClass = _baseClass;

@synthesize protocols = _protocols;
@synthesize classDeclarations = _classDeclarations;

@synthesize initializers = _initializers;
@synthesize properties = _properties;
@synthesize variables = _variables;
@synthesize classMethods = _classMethods;
@synthesize instanceMethods = _instanceMethods;


- (id)initWithTag:(NSString *)tag name:(NSString *)name baseClass:(GenClass *)baseClass {
  self = [super initWithTag:tag];
  if( self ) {
    _name = name;
    _baseClass = baseClass;
    _protocols = [NSMutableArray array];
    _classDeclarations = [NSMutableArray array];
    _initializers = [NSMutableArray array];
    _properties = [NSMutableArray array];
    _variables = [NSMutableArray array];
    _classMethods = [NSMutableArray array];
    _instanceMethods = [NSMutableArray array];
  }
  return self;
}


- (id)initWithTag:(NSString *)tag name:(NSString *)name {
  return [self initWithTag:tag name:name baseClass:nil];
}


- (id)initWithName:(NSString *)name {
  return [self initWithTag:nil name:name baseClass:nil];
}


- (id)initWithName:(NSString *)name baseClass:(GenClass *)baseClass {
  return [self initWithTag:nil name:name baseClass:baseClass];
}


- (NSString *)pointerType {
  return [NSString stringWithFormat:@"%@*", [self name]];
}


- (void)addProtocol:(GenProtocol *)protocol {
  [[self protocols] addObject:protocol];
}


- (void)addVariable:(GenVariable *)variable {
  [[self variables] addObject:variable];
}


- (void)addProperty:(GenProperty *)property {
  [[self properties] addObject:property];
}


- (void)addInitializer:(GenMethod *)method {
  [[self initializers] addObject:method];
}


- (void)addMethod:(GenMethod *)method {
  if( [method isInstanceScope] ) {
    [[self instanceMethods] addObject:method];
  } else {
    [[self classMethods] addObject:method];
  }
}


- (void)addMethods:(NSArray *)methods {
  for( GenMethod *method in methods ) {
    [self addMethod:method];
  }
}


- (NSString *)baseClassName {
  if( [self baseClass] ) {
    return [[self baseClass] name];
  } else {
    return @"NSObject";
  }
}


- (NSString *)publicClassMethodsDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self classMethods] ) {
    if( [method isPublicScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


- (NSString *)privateClassMethodsDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self classMethods] ) {
    if( [method isPrivateScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


- (NSString *)classMethodsDefinitionString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self classMethods] ) {
    [content appendString:[method definitionString]];
  }

  return content;
}


- (NSString *)publicInstanceVariablesDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenVariable *variable in [self variables] ) {
    if( [variable isInstanceScope] && [variable isPublicScope] ) {
      [content appendString:[variable declarationString]];
    }
  }

  return content;
}


- (NSString *)privateInstanceVariablesDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenVariable *variable in [self variables] ) {
    if( [variable isInstanceScope] && [variable isPrivateScope] ) {
      [content appendString:[variable declarationString]];
    }
  }

  return content;
}


- (NSString *)publicInitializersDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self initializers] ) {
    if( [method isDeclaredHere] && [method isPublicScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


- (NSString *)privateInitializersDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self initializers] ) {
    if( [method isDeclaredHere] && [method isPrivateScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


- (NSString *)initializersDefinitionString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self initializers] ) {
    [content appendFormat:@"%@\n", [method definitionString]];
  }

  return content;
}


- (NSString *)publicInstanceMethodsDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self instanceMethods] ) {
    if( [method isDeclaredHere] && [method isPublicScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


- (NSString *)privateInstanceMethodsDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self instanceMethods] ) {
    if( [method isDeclaredHere] && [method isPrivateScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


- (NSString *)instanceMethodsDefinitionString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self instanceMethods] ) {
    [content appendFormat:@"%@\n", [method definitionString]];
  }

  return content;
}


- (NSString *)publicPropertiesDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenProperty *property in [self properties] ) {
    if( [property isPublicScope] ) {
      [content appendString:[property declarationString]];
    }
  }

  return content;
}


- (NSString *)privatePropertiesDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenProperty *property in [self properties] ) {
    if( [property isPrivateScope] ) {
      [content appendString:[property declarationString]];
    }
  }

  return content;
}


- (NSString *)propertiesDefinitionString {
  NSMutableString *content = [NSMutableString string];

  for( GenProperty *property in [self properties] ) {
    [content appendString:[property definitionString]];
  }

  return content;
}


- (NSString *)publicDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( NSString *declaration in [self classDeclarations] ) {
    [content appendFormat:@"@class %@;", declaration];
  }
  [content appendString:@"\n"];

  if( [[self protocols] count] > 0 ) {
    NSString *protocolDeclarations = [[[self protocols] valueForKey:@"name"] componentsJoinedByString:@","];
    [content appendFormat:@"@interface %@ : %@ <%@>", [self name], [self baseClassName], protocolDeclarations];

  } else {
    [content appendFormat:@"@interface %@ : %@", [self name], [self baseClassName]];
  }

  if( [self hasPubliclyScopedInstanceVariables] ) {
    [content appendFormat:@" {\n"];
    [content appendFormat:@"%@\n}\n", [self publicInstanceVariablesDeclarationString]];
  } else {
    [content appendString:@"\n"];
  }

  [content appendFormat:@"%@\n", [self publicClassMethodsDeclarationString]];
  [content appendFormat:@"%@\n", [self publicPropertiesDeclarationString]];
  [content appendFormat:@"%@\n", [self publicInitializersDeclarationString]];
  [content appendFormat:@"%@\n", [self publicInstanceMethodsDeclarationString]];
  [content appendString:@"@end\n\n\n"];

  return content;
}


- (BOOL)hasPrivatelyScopedContents {
  return [self hasPrivatelyScopedClassMethods] ||
      [self hasPrivatelyScopedInstanceMethods] ||
      [self hasPrivatelyScopedProperties] ||
      [self hasPrivatelyScopedInitializers];
}


- (BOOL)hasPrivatelyScopedClassMethods {
  for( GenMethod *method in [self classMethods] ) {
    if( ([method scope] & GenPrivateScope) == GenPrivateScope ) {
      return YES;
    }
  }
  return NO;
}


- (BOOL)hasPrivatelyScopedInstanceMethods {
  for( GenMethod *method in [self instanceMethods] ) {
    if( ([method scope] & GenPrivateScope) == GenPrivateScope ) {
      return YES;
    }
  }
  return NO;
}


- (BOOL)hasPrivatelyScopedInitializers {
  for( GenMethod *initializer in [self initializers] ) {
    if( ([initializer scope] & GenPrivateScope) == GenPrivateScope ) {
      return YES;
    }
  }
  return NO;
}


- (BOOL)hasPrivatelyScopedProperties {
  for( GenProperty *property in [self properties] ) {
    if( ([property scope] & GenPrivateScope) == GenPrivateScope ) {
      return YES;
    }
  }
  return NO;
}


- (BOOL)hasPubliclyScopedInstanceVariables {
  for( GenVariable *variable in [self variables] ) {
    if( [variable isInstanceScope] && [variable isPublicScope] ) {
      return YES;
    }
  }
  return NO;
}


- (BOOL)hasPrivatelyScopedInstanceVariables {
  for( GenVariable *variable in [self variables] ) {
    if( [variable isInstanceScope] && [variable isPrivateScope] ) {
      return YES;
    }
  }
  return NO;
}


- (NSString *)privateDeclarationString {
  NSMutableString *content = [NSMutableString string];

  if( [self hasPrivatelyScopedContents] ) {
    [content appendFormat:@"@interface %@ ()\n", [self name]];
    [content appendFormat:@"%@\n", [self privateClassMethodsDeclarationString]];
    [content appendFormat:@"%@\n", [self privateInitializersDeclarationString]];
    [content appendFormat:@"%@\n", [self privatePropertiesDeclarationString]];
    [content appendFormat:@"%@\n", [self privateInstanceMethodsDeclarationString]];
    [content appendFormat:@"@end\n\n\n"];
  }

  return content;
}


- (NSString *)definitionString {
  NSMutableString *content = [NSMutableString string];

  if( [self hasPrivatelyScopedInstanceVariables] ) {
    [content appendFormat:@"@implementation %@ {\n", [self name]];
    [content appendString:[self privateInstanceVariablesDeclarationString]];
    [content appendFormat:@"}\n"];
  } else {
    [content appendFormat:@"@implementation %@\n", [self name]];
  }

  [content appendFormat:@"%@\n", [self classMethodsDefinitionString]];
  [content appendFormat:@"%@\n", [self propertiesDefinitionString]];
  [content appendFormat:@"%@\n", [self initializersDefinitionString]];
  [content appendFormat:@"%@\n", [self instanceMethodsDefinitionString]];
  [content appendString:@"@end\n\n\n"];

  return content;
}


- (GenMethod *)instanceMethodWithTag:(NSString *)tag {
  for( GenMethod *method in [self instanceMethods] ) {
    if( [[method tag] isEqualToString:tag] ) {
      return method;
    }
  }
  return nil;
}


@end
