//
//  InputDataViewController.m
//  MLStudio
//
//  Created by Мария Водолазкая on 13.02.16.
//  Copyright © 2016 Мария Водолазкая. All rights reserved.
//

#import "InputDataViewController.h"

@interface InputDataViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation InputDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
}

- (IBAction)chooseFileButtonTapped:(id)sender
{
    //this gives you a copy of an open file dialogue
    NSOpenPanel* openPanel = [NSOpenPanel openPanel];
    
    //set the title of the dialogue window
    openPanel.title = @"Choose a .PED texture file";
    
    //shoud the user be able to resize the window?
    openPanel.showsResizeIndicator = YES;
    
    //should the user see hidden files (for user apps - usually no)
    openPanel.showsHiddenFiles = NO;
    
    //can the user select a directory?
    openPanel.canChooseDirectories = NO;
    
    //can the user create directories while using the dialogue?
    openPanel.canCreateDirectories = YES;
    
    //should the user be able to select multiple files?
    openPanel.allowsMultipleSelection = NO;
    
    //an array of file extensions to filter the file list
    openPanel.allowedFileTypes = @[@"arff"];
    
    NSInteger OD = [openPanel runModal];
    NSURL *directoryUrl = [openPanel directoryURL];
    NSURL *fileUrl = [openPanel URL];
    
    
    NSLog(@"chooseFileButtonTapped: directory = %@", directoryUrl);
    
    NSLog(@"chooseFileButtonTapped: filename = %@", fileUrl);
    
    // show input preview:
    
    NSString *filePath = fileUrl.path;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *previewText = @"No Input File to Preview";

    
    if ([fm fileExistsAtPath:filePath])
    {
        previewText = [NSString stringWithContentsOfURL:fileUrl encoding:NSStringEncodingConversionAllowLossy error:nil];
    }
    
    [self.inputPreviewTextView setString:previewText];
}

@end
