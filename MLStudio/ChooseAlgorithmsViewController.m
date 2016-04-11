//
//  ChooseAlgorithmsViewController.m
//  MLStudio
//
//  Created by Мария Водолазкая on 13.02.16.
//  Copyright © 2016 Мария Водолазкая. All rights reserved.
//

#import "ChooseAlgorithmsViewController.h"
#import "AppDelegate.h"

@interface ChooseAlgorithmsViewController () <NSTableViewDataSource, NSTableViewDelegate>
{

    AppDelegate *appDelegate;
}
@end

@implementation ChooseAlgorithmsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return appDelegate.classifiers.count;
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if( [tableColumn.identifier isEqualToString:@"algorithmCell"] )
    {
        NSString *alg = [appDelegate.classifiers objectAtIndex:row];
        [cellView.textField setStringValue:alg];
        return cellView;
    }
    else
    {
        NSLog(@"useAlg[%ld] = %@", (long)row, appDelegate.useAlgorithm[row]);
        
        NSButton *checkbox = [cellView viewWithTag:200];
        checkbox.tag = row;
        [checkbox setTarget:self];
        [checkbox setAction:@selector(checkButtonTapped:)];
    }
    return cellView;
}

- (void) checkButtonTapped:(NSButton*)sender
{
    //NSLog(@"%ld checkbox touched", (long)sender.tag);
    [appDelegate.useAlgorithm replaceObjectAtIndex:sender.tag withObject:@(![appDelegate.useAlgorithm[sender.tag] boolValue]) ];
    NSLog(@"useAlg[%ld] = %@", (long)sender.tag, appDelegate.useAlgorithm[sender.tag]);
}

- (IBAction)generateStreamButtonTapped:(id)sender {
    int i = 0;
}
@end
