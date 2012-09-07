//
//  Gen.h
//  Gen
//
//  Created by Matt Mower on 30/01/2012.
//  Copyright (c) 2012 SmartFish Software Ltd.. All rights reserved.
//

#ifndef Gen_Gen_h
#define Gen_Gen_h

typedef enum {
  GenInstanceScope = 1,
  GenClassScope = 2,
  GenGlobalScope = 4,
  GenStaticScope = 8,
  GenPrivateScope = 16
} GenScope;


#import "GenObject.h"
#import "GenCompilationUnit.h"
#import "GenEnumeration.h"
#import "GenType.h"
#import "GenTypedef.h"
#import "GenClass.h"
#import "GenProtocol.h"
#import "GenMethod.h"
#import "GenArgument.h"
#import "GenProperty.h"
#import "GenVariable.h"
#import "GenStatement.h"
#import "GenCodeStatement.h"
#import "GenConditionalStatement.h"
#import "GenStatementGroup.h"

#endif
