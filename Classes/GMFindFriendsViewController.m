//
//  GMFindFriendsViewControllerViewController.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/20/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMFindFriendsViewController.h"

@implementation GMFindFriendsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setTitle:@"Find Friends"];
  [[self navigationItem] setHidesBackButton:YES];
  [[self tableView] setBackgroundColor:GM_BLUE_GRAY_COLOR];
  
  UIBarButtonItem *done = [[UIBarButtonItem alloc] 
    initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
    target:self 
    action:@selector(didFinishSelectingTags:)];
  
  [[self navigationItem] setRightBarButtonItem: done];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  
  switch(indexPath.row) {
    case 0:
      [[cell textLabel] setText:@"Facebook friends"];
      break;
    case 1:
      [[cell textLabel] setText:@"Twitter friends"];
      break;
    case 2:
      [[cell textLabel] setText:@"Suggested friends"];
      break;
  }
  
  [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
