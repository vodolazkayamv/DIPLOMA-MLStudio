//
//  Algorithm.h
//  MLStudio
//
//  Created by Мария Водолазкая on 09.04.16.
//  Copyright © 2016 Мария Водолазкая. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface Algorithm : NSManagedObject

@property NSString *name;
@property NSString *wekaClassName;
@property int identificatorNumber;


// Insert code here to declare functionality of your managed object subclass
+ (void)initWithName:(NSString *)name wekaClassName:(NSString *)wekaName idNumber:(int)idnum;

@end

NS_ASSUME_NONNULL_END