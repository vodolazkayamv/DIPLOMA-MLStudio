//
//  AppDelegate.m
//  MLStudio
//
//  Created by Мария Водолазкая on 13.02.16.
//  Copyright © 2016 Мария Водолазкая. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    //NSArray *nameArray;
    //NSArray *classifiers;
    //NSMutableArray *useAlgorithm;
}
@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.nameArray = @[
                  @"NaiveBayes",
                  @"AdaBoostM1",
                  @"ConjunctiveRule",
                  @"Prism",
                  @"ZeroR",
                  @"Id3",
                  @"J48",
                  @"LMT",
                  @"RandomForest",
                  @"RandomTree"
                  ];
    
    self.classifiers = @[
                    @"Naive Bayes",
                    @"AdaBoost M1",
                    @"Conjunctive Rule",
                    @"Prism",
                    @"Zero R",
                    @"Id3",
                    @"J48",
                    @"LMT",
                    @"Random Forest",
                    @"Random Tree"
                    ];
    
    self.useAlgorithm = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < _classifiers.count; i++)
    {
        [_useAlgorithm addObject: [NSNumber numberWithBool:NO]];
    }
    
    self.JAVAClass = @[
                   @"weka.classifiers.bayes.NaiveBayes",
                   @"weka.classifiers.meta.AdaBoostM1",
                   @"weka.classifiers.rules.ConjunctiveRule",
                   @"weka.classifiers.rules.Prism",
                   @"weka.classifiers.rules.ZeroR",
                   @"weka.classifiers.trees.Id3",
                   @"weka.classifiers.trees.J48",
                   @"weka.classifiers.trees.LMT",
                   @"weka.classifiers.trees.RandomForest",
                   @"weka.classifiers.trees.RandomTree"
                   ];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
