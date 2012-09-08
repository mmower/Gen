//
//  GenClass.m
//  Gen
//
//  Created by Matt Mower on 30/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#import "GenClass.h"

#import "GenMethod.h"

/**
* Instances of GenClass are used to represent Objective-C classes. A GenClass can take another GenClass as its
* base class or can be based on NSObject.
*
* To define the behaviour of the class add protocols, methods, properties, and instance variables.
*
* @warning it's not currently possible to use a named base class but this is probably a useful thing to allow in the future
*/

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

/**
* @name initializers
*/

/**
* Initialize a tagged GenClass
*
* @param tag the tag by which the class can be looked up in any compilation unit it has been added to
* @param name the class name
* @param baseClass a GenClass that acts as the base class, pass nil to use NSObject
* @return corresponding instance of GenClass
*/
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


/**
* Initialize a tagged GenClass for a class inheriting from NSObject
*
* @param tag the tag by which the class can be looked up in any compilation unit it has been added to
* @param name the class name
* @return corresponding instance of GenClass
*/
- (id)initWithTag:(NSString *)tag name:(NSString *)name {
  return [self initWithTag:tag name:name baseClass:nil];
}


/**
* Initialize a GenClass for a class inheriting from NSObject
*
* @param name the class name
* @return corresponding instance of GenClass
*/
- (id)initWithName:(NSString *)name {
  return [self initWithTag:nil name:name baseClass:nil];
}


/**
* Initialize a GenClass
*
* @param name the class name
* @param baseClass a GenClass that acts as the base class, pass nil to use NSObject
* @return corresponding instance of GenClass
*/- (id)initWithName:(NSString *)name baseClass:(GenClass *)baseClass {
  return [self initWithTag:nil name:name baseClass:baseClass];
}


/**
* @name Retrieve class information
*/


/**
* Returns the C type for a pointer to this class that can be used in variable or
* argument declarations.
*
* @return pointer type name
*/
- (NSString *)pointerType {
  return [NSString stringWithFormat:@"%@*", [self name]];
}


/**
* Return the name of the base class of this class.
*
* @return the base class name
*/

- (NSString *)baseClassName {
  if( [self baseClass] ) {
    return [[self baseClass] name];
  } else {
    return @"NSObject";
  }
}


/**
* Return the GenMethod representing an instance method of this class with the given tag
*
* @param tag tag of the method to lookup
* @return GenMethod of the tagged method
*/
- (GenMethod *)instanceMethodWithTag:(NSString *)tag {
  for( GenMethod *method in [self instanceMethods] ) {
    if( [[method tag] isEqualToString:tag] ) {
      return method;
    }
  }
  return nil;
}



/**
* @name Add behaviours to the class
*/


/**
* Specify that this class conforms to a protocol.
*
* @param protocol the GenProtocol specifying the protocol this class should implement
*/
- (void)addProtocol:(GenProtocol *)protocol {
  [[self protocols] addObject:protocol];
}


/**
* Add an instance variable to the class.
*
* @param variable the GenVariable defining the instance variable to add
*/
- (void)addVariable:(GenVariable *)variable {
  [[self variables] addObject:variable];
}


/**
* Add a property to the class.
*
* @param property the GenProperty defining the property to add to the class
*/
- (void)addProperty:(GenProperty *)property {
  [[self properties] addObject:property];
}


/**
* Adds one of the -initXXX group of methods to the class
*
* @param method the GenMethod for the initializer
*/
- (void)addInitializer:(GenMethod *)method {
  [[self initializers] addObject:method];
}


/**
* Adds an instance or class method to the class.
*
* @param method the GenMethod for the method to add to the class
*/
- (void)addMethod:(GenMethod *)method {
  if( [method isInstanceScope] ) {
    [[self instanceMethods] addObject:method];
  } else {
    [[self classMethods] addObject:method];
  }
}


/**
* Adds a group of instance or class methods to the class.
*
* @param methods an array of GenMethods to add to the class
*/
- (void)addMethods:(NSArray *)methods {
  for( GenMethod *method in methods ) {
    [self addMethod:method];
  }
}


/**
* @name Format generators for use by GenCompilationUnit to write out the class interface & implementation
*/


/**
* Return a formatted string containing the declaration of all public class
* methods of this class suitable for adding to a classinterface.
*
* @return public class methods declaration string
*/
- (NSString *)publicClassMethodsDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self classMethods] ) {
    if( [method isPublicScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


/**
* Return a formatted string containing the declaration of all the private
* class methods for this class suitable for adding to a class extension.
*
* @return private class methods declaration string
*/
- (NSString *)privateClassMethodsDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self classMethods] ) {
    if( [method isPrivateScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


/**
* Return a formatted string containing the definition of all class methods
* of this class suitable for inclusion in a class implementation.
*
* @return class methods definition string
*/

- (NSString *)classMethodsDefinitionString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self classMethods] ) {
    [content appendString:[method definitionString]];
  }

  return content;
}


/**
* Return a formatted string containing the declaration of all public instance
* variables of the class suitable for inclusion in a class interface.
*
* @return public instance variables declaration string
*/
- (NSString *)publicInstanceVariablesDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenVariable *variable in [self variables] ) {
    if( [variable isInstanceScope] && [variable isPublicScope] ) {
      [content appendString:[variable declarationString]];
    }
  }

  return content;
}


/**
* Return a formatted string containing the declaration of all private instance
* variables of the class suitable for inclusion in a class extension.
*
* @return private instance variables declaration string
*/
- (NSString *)privateInstanceVariablesDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenVariable *variable in [self variables] ) {
    if( [variable isInstanceScope] && [variable isPrivateScope] ) {
      [content appendString:[variable declarationString]];
    }
  }

  return content;
}


/**
* Return a formatted string containing the declaration of all public
* initializer methods suitable for inclusion in a class interface.
*
* @return public initializer declarations string
*/
- (NSString *)publicInitializersDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self initializers] ) {
    if( [method isDeclaredHere] && [method isPublicScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


/**
* Return a formatted string containing the declaration of all private
* initializer methods suitable for inclusion in a class extension.
*
* @return private initializer declaractions string
*/
- (NSString *)privateInitializersDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self initializers] ) {
    if( [method isDeclaredHere] && [method isPrivateScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


/**
* Return a formatted string containing the definition of all initializer
* methods suitable for inclusion in a class implementation.
*
* @return initializer definitions string
*/
- (NSString *)initializersDefinitionString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self initializers] ) {
    [content appendFormat:@"%@\n", [method definitionString]];
  }

  return content;
}


/**
* Return a formatted string containing the declaration of all public instance
* methods suitable for inclusion in a class interface.
*
* @return public instance methods declaration string
*/
- (NSString *)publicInstanceMethodsDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self instanceMethods] ) {
    if( [method isDeclaredHere] && [method isPublicScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


/**
* Return a formatted string containing the declaration of all private instance
* methods suitable for inclusion in a class extension.
*
* @return private instance methods declaration string
*/
- (NSString *)privateInstanceMethodsDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self instanceMethods] ) {
    if( [method isDeclaredHere] && [method isPrivateScope] ) {
      [content appendString:[method declarationString]];
    }
  }

  return content;
}


/**
* Return a formatted string containing the definition of all instance
* methods suitable for inclusion in a class implementation.
*
* @return instance methods definitions string
*/
- (NSString *)instanceMethodsDefinitionString {
  NSMutableString *content = [NSMutableString string];

  for( GenMethod *method in [self instanceMethods] ) {
    [content appendFormat:@"%@\n", [method definitionString]];
  }

  return content;
}


/**
* Return a formatting string containing the declaration of all public properties
* suitable for inclusion in a class interface.
*
* @return public properties declaration string
*/
- (NSString *)publicPropertiesDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenProperty *property in [self properties] ) {
    if( [property isPublicScope] ) {
      [content appendString:[property declarationString]];
    }
  }

  return content;
}


/**
* Return a formatting string containing the declaration of all private properties
* suitable for inclusion in a class extension.
*
* @return private properties declaration string
*/
- (NSString *)privatePropertiesDeclarationString {
  NSMutableString *content = [NSMutableString string];

  for( GenProperty *property in [self properties] ) {
    if( [property isPrivateScope] ) {
      [content appendString:[property declarationString]];
    }
  }

  return content;
}


/**
* Return a formatted string containing the definition of all properties
* suitable for inclusion in a class implementation.
*
* @return properties definitions string
*/
- (NSString *)propertiesDefinitionString {
  NSMutableString *content = [NSMutableString string];

  for( GenProperty *property in [self properties] ) {
    [content appendString:[property definitionString]];
  }

  return content;
}


/**
* Return a formatted string containing public declaration of the class including any necessary
* forward class declarations.
*
* @return class declaration string
*/
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


/**
* Return a formatted string containing the class extension for the class.
*
* @return class extension string
*/
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


/**
* Return a formatted string containing the implementation of the class.
*
* @return class implementation string
*/
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


/**
* @name Scope queries
*/

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

@end
