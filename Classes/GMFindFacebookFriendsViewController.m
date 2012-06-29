//
//  GMFindFacebookFriendsViewController.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/27/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMFindFacebookFriendsViewController.h"
#import "GMAppDelegate.h"
#import "GMFollowButtonView.h"
#import "MBProgressHUD.h"

@implementation GMFindFacebookFriendsViewController

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
  } else {
    self.profiles = [NSMutableArray array];
    [self showFriends];
  }
}

- (void)logoutOfFacebook:(id)sender
{
  [self.facebook logout];
}

- (void)fbDidLogin
{
  [super fbDidLogin];
  
  self.profiles = [NSMutableArray array];
  [self showFriends];
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
        [self.profiles addObjectsFromArray:result];
      } else if([result isKindOfClass:[NSDecimalNumber class]]) {
        [self.profiles addObject:[result stringValue]];
      }
      [self.profilesTableView reloadData];
      break;
    }
  }
  
  [self hideActivityIndicator];
}

@end
