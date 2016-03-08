//
//  ChooseAlgorithmsViewController.h
//  MLStudio
//
//  Created by Мария Водолазкая on 13.02.16.
//  Copyright © 2016 Мария Водолазкая. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ChooseAlgorithmsViewController : NSViewController
@property (weak) IBOutlet NSTableView *tableView;
- (IBAction)generateStreamButtonTapped:(id)sender;

@end
