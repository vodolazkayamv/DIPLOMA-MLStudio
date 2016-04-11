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
        [importHeaderPart appendString:@"import weka.core.Instance; \nimport weka.core.Instances; \nimport weka.core.converters.ArffLoader; \nimport java.io.File;\n\n import weka.core.converters.ConverterUtils.DataSource; \nimport weka.core.Utils; \nimport weka.classifiers.Classifier;\nimport weka.classifiers.Evaluation;\nimport java.util.Random;\n\n"];
        
        [importHeaderPart appendString:@"// selected algorithms to train:\n"];
        
        NSMutableString *consoleExample = [NSMutableString stringWithFormat:@"java Generated %@ -x 10 -s 1 ", appDelegate.inputFileName];
        
        for (int i = 0; i < appDelegate.useAlgorithm.count; i++)
        {
            
            if ([appDelegate.useAlgorithm[i] boolValue]) {
                
                [importHeaderPart appendFormat:@"import %@; \n", appDelegate.JAVAClass[i]];
                [consoleExample appendString:[NSString stringWithFormat:@"-W%d \"%@\" ",i, appDelegate.JAVAClass[i]]];

            }
        }
        
        [importHeaderPart appendString:[NSString stringWithFormat:@"\n\n// console example:\n// %@", consoleExample]];
        
        
        ////////// BODY
        
        // start JAVA class
        NSMutableString *JAVAClass = [NSMutableString stringWithString:@"\n\npublic class Generated {\n"];
        
        { ///// VOID MAIN

            [JAVAClass appendString:@"public static void main(String[] args) throws Exception {\n"];
            
            NSMutableString *arffLoaderPart = [NSMutableString stringWithString:@"// load data\n Instances data = DataSource.read(args[0]);\n// other options\nint seed  = Integer.parseInt(Utils.getOption(\"s\", args));\nint folds = Integer.parseInt(Utils.getOption(\"x\", args));"];
            [JAVAClass appendString:arffLoaderPart];
            
            for (int i = 0; i < appDelegate.classifiers.count; i++)
            {
                if ([appDelegate.useAlgorithm[i] boolValue]) {
                    [JAVAClass appendFormat:@"\n{\n// train %@\n", appDelegate.classifiers[i]];
                    
                    NSMutableString *trainPart = [NSMutableString stringWithFormat:@"%@ nb = new %@(); \nnb.buildClassifier(structure);\n",appDelegate.nameArray[i], appDelegate.nameArray[i]];
                    
                    NSMutableString *trainClassPart = [NSMutableString stringWithFormat:@"////////////////////////////////////////////////////////////\n// setting CLASS attribute (att to use in classification) //\n////////////////////////////////////////////////////////////\n\nString clsIndex = \"last\";\nif (clsIndex.length() == 0)\nclsIndex = \"last\";\nif (clsIndex.equals(\"first\"))\ndata.setClassIndex(0);\nelse if (clsIndex.equals(\"last\"))\ndata.setClassIndex(data.numAttributes() - 1);\nelse\ndata.setClassIndex(Integer.parseInt(clsIndex) - 1);\n\n////////////////\n// classifier //\n////////////////\nString[] tmpOptions;\nString classname;\ntmpOptions     = Utils.splitOptions(Utils.getOption(\"W%d\", args));\nclassname      = tmpOptions[0];\ntmpOptions[0]  = \"\";\nClassifier cls = (Classifier) Utils.forName(Classifier.class, classname, tmpOptions);\n\n// output evaluation\nSystem.out.println();\nSystem.out.println(\"=== Setup ===\");\nSystem.out.println(\"Classifier: \" + cls.getClass().getName() + \" \" + Utils.joinOptions(cls.getOptions()));\nSystem.out.println(\"Dataset: \" + data.relationName());\nSystem.out.println();\n\n// model output\ncls.buildClassifier(data);\n System.out.println(cls);", i];
                    
                    NSMutableString *crossValidationPart = [NSMutableString stringWithFormat:@"\n\n// randomize data\nRandom rand = new Random(seed);\nInstances randData = new Instances(data);\nrandData.randomize(rand);\nif (randData.classAttribute().isNominal())\nrandData.stratify(folds);\n\n// perform cross-validation\nEvaluation eval = new Evaluation(randData);\nfor (int n = 0; n < folds; n++) {\nInstances train = randData.trainCV(folds, n);\nInstances test = randData.testCV(folds, n);\n// the above code is used by the StratifiedRemoveFolds filter, the\n\n// code below by the Explorer/Experimenter:\n// Instances train = randData.trainCV(folds, n, rand);\n\n// build and evaluate classifier\n\nClassifier clsCopy = Classifier.makeCopy(cls);\nclsCopy.buildClassifier(train);\neval.evaluateModel(clsCopy, test);\n}\n\n// output evaluation\nSystem.out.println();\nSystem.out.println(\"=== Cross-validation Setup ===\");\n System.out.println(\"Folds: \" + folds);\nSystem.out.println(\"Seed: \" + seed);\nSystem.out.println();\nSystem.out.println(eval.toSummaryString(\"=== \" + folds + \"-fold Cross-validation ===\", false));"];
                    
                    //incremental:
                    //\nInstance current; \nwhile ((current = loader.getNextInstance(structure)) != null) \nnb.updateClassifier(current);\n", appDelegate.nameArray[i], appDelegate.nameArray[i]];
                    
                    [JAVAClass appendString:trainClassPart];
                    [JAVAClass appendString:crossValidationPart];
                    [JAVAClass appendString:@"\n}\n"];
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
