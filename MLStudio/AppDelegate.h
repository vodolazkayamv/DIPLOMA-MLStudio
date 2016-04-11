//
//  AppDelegate.h
//  MLStudio
//
//  Created by Мария Водолазкая on 13.02.16.
//  Copyright © 2016 Мария Водолазкая. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong, retain) NSArray *nameArray;
@property (strong, retain) NSArray *classifiers;
@property (strong, retain) NSMutableArray *useAlgorithm;
@property (strong, retain) NSArray *JAVAClass;
@property (retain) NSString* inputFileName;

@end

