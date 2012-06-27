//
//  GMSuggestedFoodTagsViewController.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/20/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMSuggestedFoodTagsViewController.h"
#import "GMSuggestedFoodHeaderView.h"
#import "GMSuggestedFoodsStore.h"
#import "GMFindFriendsViewController.h"

NSString * const kGMFavoriteFoodTags = @"GrubmFavoriteFoodTags";

@implementation GMSuggestedFoodTagsViewController

@synthesize selectedKeys;

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setSelectedKeys:[NSMutableSet set]];
  [self setTitle:@"Follow Food"];
  [[self navigationItem] setHidesBackButton:YES];
  [[self tableView] setBackgroundColor:GM_BLUE_GRAY_COLOR];
  
  CGRect bounds = [[UIScreen mainScreen] bounds];
  GMSuggestedFoodHeaderView *headerView = [[GMSuggestedFoodHeaderView alloc] 
    initWithFrame:CGRectMake(0, 0, bounds.size.width, 83.0f)];
  [[self tableView] setTableHeaderView:headerView];
  
  UIBarButtonItem *done = [[UIBarButtonItem alloc] 
    initWithTitle:@"Next" 
    style:UIBarButtonItemStyleDone 
    target:self 
    action:@selector(didFinishSelectingTags:)];
  
  [[self navigationItem] setRightBarButtonItem: done];
}

#pragma mark - SSpickerViewController

- (void)loadKeys 
{
  [self setKeys:[[GMSuggestedFoodsStore sharedStore] allTags]];
}

- (NSString *)cellTextForKey:(NSString *)key 
{
  return [@"#" stringByAppendingString:key];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  NSString *key = [[self keys] objectAtIndex:indexPath.row];
  
  if([cell accessoryType] == UITableViewCellAccessoryCheckmark) {
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    DLog(@"removing object %@", key);
    [[self selectedKeys] removeObject:key];
    DLog(@"selectedKeys is now: %@", [self selectedKeys]);
  } else {
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    DLog(@"adding object %@", key);
    [[self selectedKeys] addObject:key];
    DLog(@"selectedKeys is now: %@", [self selectedKeys]);
  }
  
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	self.currentIndexPath = indexPath;
}

#pragma mark - Done Button delegate

- (void)didFinishSelectingTags:(id)sender
{
  NSMutableSet *selectedTags = [self selectedKeys];
  DLog(@"selectedKeys: %@", selectedTags);
  
  if([selectedTags count] > 0) {
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:[selectedTags allObjects]] forKey:kGMFavoriteFoodTags];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
  
  DLog(@"Saving food tags: %@", [[NSUserDefaults standardUserDefaults] objectForKey:kGMFavoriteFoodTags]);
  
  GMFindFriendsViewController *findFriendsController = [[GMFindFriendsViewController alloc] 
    initWithStyle:UITableViewStyleGrouped];
  [[self navigationController] pushViewController:findFriendsController animated:YES];
}

@end
