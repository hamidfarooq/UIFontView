//
//  ViewController.m
//  UIFontView
//
//  Created by Hamid Farooq on 03/09/2013.
//  Copyright (c) 2013 Wemo Technologies. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    listOfFonts = [[NSMutableArray alloc] init];
    
    NSArray *familyNames = [UIFont familyNames];
    for (NSString *familyName in familyNames)
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for (NSString *fontName in fontNames)
        {
            [listOfFonts addObject:fontName];
        }
    }
    
    [listOfFonts sortUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.tableView reloadData];
}

- (void)dealloc
{
    [listOfFonts release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listOfFonts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]))
        return 120.0f;
    else
        return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.numberOfLines = 2;
        cell.detailTextLabel.numberOfLines = 2;
    }
    
    NSString *fontName = [listOfFonts objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont fontWithName:fontName size:self.fontSize];
    cell.textLabel.text = [NSString stringWithFormat:@"%.1f - %@\nABCDEFGHIJKLMNOPQRSTUVWXYZ", self.fontSize, fontName];
    
    cell.detailTextLabel.font = [UIFont fontWithName:fontName size:self.fontSize];
    cell.detailTextLabel.text = @"\nabcdefghijklmnopqrstuvwxyz";
    
    return cell;
}

- (CGFloat)fontSize
{
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]))
        return 20.0f;
    else
        return 14.0f;
}

@end
