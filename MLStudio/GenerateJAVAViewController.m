//
//  GenerateJAVAViewController.m
//  MLStudio
//
//  Created by Мария Водолазкая on 15.02.16.
//  Copyright © 2016 Мария Водолазкая. All rights reserved.
//

#import "GenerateJAVAViewController.h"
#import "AppDelegate.h"

@interface GenerateJAVAViewController ()
{
    AppDelegate *appDelegate;
    
}
@end

@implementation GenerateJAVAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];

    NSString *filePath = @"/Users/mv/Documents/DIPLOMA/MLStudio/MLStudio/Generated.Java";
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath])
    {
        
        
        ///////// HEADER
        
        NSMutableString *importHeaderPart = [NSMutableString stringWithFormat:@"//Generated JAVA file \n"];
        [importHeaderPart appendString:@"import weka.core.Instance; \nimport weka.core.Instances; \nimport weka.core.converters.ArffLoader; \nimport java.io.File;\n\n"];
        
        for (int i = 0; i < appDelegate.useAlgorithm.count; i++)
        {
            
            if ([appDelegate.useAlgorithm[i] boolValue]) {
                
                [importHeaderPart appendFormat:@"import %@; \n", appDelegate.JAVAClass[i]];
            }
        }
        
        
        ////////// BODY
        
        // start JAVA class
        NSMutableString *JAVAClass = [NSMutableString stringWithString:@"\n\npublic class Generated {\n"];
        
        { ///// VOID MAIN

            [JAVAClass appendString:@"public static void main(String[] args) throws Exception {\n"];
            
            NSMutableString *arffLoaderPart = [NSMutableString stringWithString:@"// load data\n ArffLoader loader = new ArffLoader(); \nloader.setFile(new File(args[0])); \nInstances structure = loader.getStructure(); \nstructure.setClassIndex(structure.numAttributes() - 1);\n"];
            [JAVAClass appendString:arffLoaderPart];
            
            for (int i = 0; i < appDelegate.classifiers.count; i++)
            {
                if ([appDelegate.useAlgorithm[i] boolValue]) {
                    [JAVAClass appendFormat:@"\n{\n// train %@\n", appDelegate.classifiers[i]];
                    
                    NSMutableString *trainPart = [NSMutableString stringWithFormat:@"%@ nb = new %@(); \nnb.buildClassifier(structure);\n",appDelegate.nameArray[i], appDelegate.nameArray[i]];
                    
                    //incremental:
                    //\nInstance current; \nwhile ((current = loader.getNextInstance(structure)) != null) \nnb.updateClassifier(current);\n", appDelegate.nameArray[i], appDelegate.nameArray[i]];
                    
                    [JAVAClass appendString:trainPart];
                    [JAVAClass appendString:@"// output generated model \nSystem.out.println(nb);\n}\n"];
                }
            }
            // end MAIN
            [JAVAClass appendString:@"}\n"];
        }
        
        // end JAVA class
        [JAVAClass appendString:@"\n}"];
        
        NSError *error;
        [importHeaderPart appendString:JAVAClass];
        [importHeaderPart writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    

   
}

@end
