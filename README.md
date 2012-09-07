Gen - An Objective-C Code Generator

The Gen framework implements a major chunk of an Objective-C code generator that I build while I was working on Statec. I don't claim that
it's complete but it has support for most of the features of Objective-C classes including protocols and properties.

Gen provides a set of classes, such as `GenClass`, `GenProtocol`, and `GenMethod` that can be used to model a set of Objective-C classes
and protocols. At the method level code is inserted using a template string.

Here's an example of creating a class taken from the Statec sources:

    - (GenClass *)stateBaseClass {
      // Create the base class <FooState> for the states
      GenClass *class = [[GenClass alloc] initWithName:[NSString stringWithFormat:@"%@%@State",
                                                                                      [[self machine] prefix],
                                                                                      [[self machine] name]]];
      GenProperty *nameProperty = [[GenProperty alloc] initWithType:@"NSString*"
                                                               name:@"name"
                                                         attributes:GenPropertyStrong | GenPropertyReadonly];
      [class addProperty:nameProperty];

      GenMethod *initializer = [[GenMethod alloc] initWithScope:GenInstanceScope
                                                     returnType:@"id"
                                                       selector:@selector(initWithName:)];
      [initializer addArgument:[[GenArgument alloc] initWithType:@"NSString*"
                                                            name:@"name"]];
      [[initializer body] append:
                                @"  self = [super init];\n"
                                @"  if( self ) {\n"
                                @"    _name = name;\n"
                                @"  }\n"
                                @"  return self;\n"
      ];
      [class addMethod:initializer];

      return class;
    }

Everything is finally wrapped up in a `GenCompilationUnit` object that knows how to write out the corresponding .m/.h files and
their contents. At the method-body level it breaks down to, essentially, stringWithFormat: In practice trying to model the structure
of methods in code got tedious for little reward, I found it was easier to write them as format strings.

In practice Gen works pretty well although I will grant that it's verbose and there are rough edges I've not had time to rework.
