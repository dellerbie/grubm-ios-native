//
//  GMFindFacebookFriendsViewController.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/27/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMFindFacebookFriendsViewController.h"
#import "GMAppDelegate.h"
#import "MBProgressHUD.h"

@implementation GMFindFacebookFriendsViewController

@synthesize friendsTableView = _friendsTableView;
@synthesize friendsUsingApp = _friendsUsingApp;

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(logoutOfFacebook:)];
  [[self navigationItem] setRightBarButtonItem: logout];

  GMAppDelegate *delegate = (GMAppDelegate *)[[UIApplication sharedApplication] delegate];
  delegate.facebook = self.facebook;
  
  if(![delegate.facebook isSessionValid]) {
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"email", @"publish_stream", nil];
    [self.facebook authorize:permissions];
  }
  
  self.friendsUsingApp = [NSMutableArray array];
  [self showFriends];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  self.friendsTableView = nil;
}

- (void)loadView
{
  UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
  [view setBackgroundColor:[UIColor whiteColor]];
  self.view = view;
  
  self.friendsTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
  self.friendsTableView.backgroundColor = [UIColor whiteColor];
  self.friendsTableView.delegate = self;
  self.friendsTableView.dataSource = self;
  self.friendsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.friendsTableView];
}

- (void)logoutOfFacebook:(id)sender
{
  [self.facebook logout];
}

- (void)fbDidLogout
{
  [super fbDidLogout];
  [[self navigationController] popViewControllerAnimated:YES];
}

- (void)showFriends
{
  [self showActivityIndicator];
  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"friends.getAppUsers" forKey:@"method"];
  currentApiCall = kGraphApiUserFriendsUsingApp;
  [self.facebook requestWithParams:params andDelegate:self];
}

- (void)showActivityIndicator
{
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideActivityIndicator
{
  [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
  if([result isKindOfClass:[NSArray class]] && ([result count] > 0)) {
    result = [result objectAtIndex:0];
  }
  
  switch(currentApiCall) {
    case(kGraphApiUserFriendsUsingApp):
    {
      DLog(@"FB response: %@", result);
      if([result isKindOfClass:[NSArray class]]) {
        [self.friendsUsingApp addObjectsFromArray:result];
      } else if([result isKindOfClass:[NSDecimalNumber class]]) {
        [self.friendsUsingApp addObject:[result stringValue]];
      }
      [self.friendsTableView reloadData];
      break;
    }
  }
  
  [self hideActivityIndicator];
}

#pragma mark - UITableView datasource & delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.friendsUsingApp.count || 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UIButton *button;

  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if(!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.textColor = [UIColor grayColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    button.frame = CGRectMake(cell.frame.size.width - 75 - 20, 10, 80, 24);
    [button addTarget:self action:@selector(followUser:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:button];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGFloat activityIndicatorX = (button.frame.origin.x + (button.frame.size.width/2)) - 10;
    activityIndicator.frame = CGRectMake(activityIndicatorX, 7, 30, 30);
    [cell.contentView addSubview:activityIndicator];
  } else {
    // find the button
    for(UIView *subview in cell.contentView.subviews) {
      if([subview isKindOfClass:[UIButton class]]) {
        button = (UIButton *)subview;
      }
    }
  }
  
  if([self.friendsUsingApp count] == 0) {
    DLog(@"No friends");
    cell.textLabel.text = @"No Facebook friends found.";
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    cell.textLabel.textColor = [UIColor grayColor];
  } else {
    cell.textLabel.text = [self.friendsUsingApp objectAtIndex:indexPath.row];
    
    // create the button with the correct state
    // based on the model
    
    [self showState:@"Follow" forButton:button];
    button.tag = indexPath.row;
  }
  
  return cell;
}

- (void)followUser:(id)sender
{
  UIButton *button = (UIButton *)sender;
  DLog(@"follow user: %@", [self.friendsUsingApp objectAtIndex:button.tag]);
  
  // make a call to the API, show an activity indicator, hide the button
  // update the model inside of friendsUsingApp array
  // change the button state  
        
  UIActivityIndicatorView *activityIndicator;
  for(UIView *subview in button.superview.subviews) {
    if([subview isKindOfClass:[UIActivityIndicatorView class]]) {
      activityIndicator = (UIActivityIndicatorView *)subview;
    }
  }
  
//  [activityIndicator startAnimating];
//  button.hidden = YES;
  [self toggleStateForButton:button];
}

- (void)showFollowStateForButton:(UIButton *)button
{
  [self showState:@"Follow" forButton:button];
}

- (void)showFollowingStateForButton:(UIButton *)button
{
  [self showState:@"Following" forButton:button];
}

- (void)showState:(NSString *)state forButton:(UIButton *)button
{
  NSString *backgroundImage;
  if([state isEqualToString:@"Following"]) {
    backgroundImage = @"greenButton.png";
  } else {
    backgroundImage = @"blueButton.png";
  }

  [button setTitle:state forState:UIControlStateNormal];
  UIImage *buttonBackground = [[UIImage imageNamed:backgroundImage] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
  [button setBackgroundImage:buttonBackground forState:UIControlStateNormal];
  [button setBackgroundImage:buttonBackground forState:UIControlStateHighlighted];
  
  UIActivityIndicatorView *activityIndicator;
  for(UIView *subview in button.superview.subviews) {
    if([subview isKindOfClass:[UIActivityIndicatorView class]]) {
      activityIndicator = (UIActivityIndicatorView *)subview;
    }
  }
}

- (void)toggleStateForButton:(UIButton *)button
{
  NSString *buttonTitle = button.titleLabel.text;
  NSString *newTitle = @"Following";
  
  if([buttonTitle isEqualToString:@"Following"]) {
    newTitle = @"Follow";
  }
  
  [self showState:newTitle forButton:button];
}

@end
