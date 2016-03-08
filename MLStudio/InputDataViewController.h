//
//  InputDataViewController.h
//  MLStudio
//
//  Created by Мария Водолазкая on 13.02.16.
//  Copyright © 2016 Мария Водолазкая. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

@interface InputDataViewController : NSViewController
- (IBAction)chooseFileButtonTapped:(id)sender;
@property (unsafe_unretained) IBOutlet NSTextView *inputPreviewTextView;

@end
