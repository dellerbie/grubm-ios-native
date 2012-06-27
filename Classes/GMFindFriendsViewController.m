//
//  GMFindFriendsViewControllerViewController.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/20/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMFindFriendsViewController.h"
#import "GMAppDelegate.h"

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
  
  // create facebook instance and set it in the app delegate
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
  GMAppDelegate *delegate = (GMAppDelegate *)[[UIApplication sharedApplication] delegate];
  
  switch(indexPath.row) {
    case 0:
      [[cell textLabel] setText:@"Facebook friends"];      
      if([delegate.facebook isSessionValid]) {
        [cell setAccessoryType: UITableViewCellAccessoryCheckmark];
      }
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
  GMAppDelegate *delegate = (GMAppDelegate *)[[UIApplication sharedApplication] delegate];
  if(indexPath.row == 0) {
    if(![delegate.facebook isSessionValid]) {
      NSArray *permissions = [[NSArray alloc] initWithObjects:@"email", @"publish_stream", nil];
      [delegate.facebook authorize:permissions];
    } else {
      // show the facebook friends controller
    }
  }
}

@end
