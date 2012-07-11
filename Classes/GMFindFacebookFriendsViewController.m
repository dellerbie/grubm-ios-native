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
#import "GMProfile.h"
#import "MBProgressHUD.h"

@implementation GMFindFacebookFriendsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(logoutOfFacebook:)];
  [[self navigationItem] setRightBarButtonItem: logout];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
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
  
  DLog(@"fbDidLogin");
  
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
      NSMutableArray *fbProfileIds = [NSMutableArray array];
      if([result isKindOfClass:[NSArray class]]) {
        //[self.profiles addObjectsFromArray:result];
        [fbProfileIds addObjectsFromArray:result];
      } else if([result isKindOfClass:[NSDecimalNumber class]]) {
        //[self.profiles addObject:[result stringValue]];
        [fbProfileIds addObject:[result stringValue]];
      }
      self.profiles = [self requestProfiles:fbProfileIds];
      DLog(@"profiles => %@", self.profiles);
      [self.profilesTableView reloadData];
      break;
    }
  }
  
  [self hideActivityIndicator];
}

- (NSMutableArray *)requestProfiles:(NSArray *)facebookProfileIds
{
  //NSString *joinedFBIds = [facebookProfileIds componentsJoinedByString:@","];
  // send the request to the server
  
  NSDictionary *p1 = [NSMutableDictionary 
    dictionaryWithObjectsAndKeys:
      @"Sean Murphy", @"name", 
      @"smurphy5", @"username",
      @"ablj12301", @"id", 
      [NSDictionary 
        dictionaryWithObjectsAndKeys:
          @"http://s3.amazonaws.com/dellerbie-places-phl/9a3d3fd3b2a5c2870900fc04cb2a58155ccd2cd9_lg.jpg", @"large", 
          @"http://s3.amazonaws.com/dellerbie-places-phl/9a3d3fd3b2a5c2870900fc04cb2a58155ccd2cd9_sm.jpg", @"thumb",nil], @"avatar",
      nil];
  NSDictionary *p2 = [NSMutableDictionary 
  dictionaryWithObjectsAndKeys:
    @"Derrick Deans", @"name", 
    @"dubd69", @"username",
    @"abc1234", @"id", 
    [NSDictionary 
      dictionaryWithObjectsAndKeys:
        @"http://s3.amazonaws.com/dellerbie-places-phl/d1859bd19aecbdd4b74c98c263b0dfcfdec2d1af_lg.jpg", @"large", 
        @"http://s3.amazonaws.com/dellerbie-places-phl/d1859bd19aecbdd4b74c98c263b0dfcfdec2d1af_sm.jpg", @"thumb",nil], @"avatar",
    nil];

  NSDictionary *p3 = [NSMutableDictionary 
    dictionaryWithObjectsAndKeys:
      @"Beavis Buffcoat", @"name", 
      @"eagerbeaver", @"username",
      @"def12345", @"id", 
      [NSDictionary 
        dictionaryWithObjectsAndKeys:
          @"http://s3.amazonaws.com/dellerbie-places-food-images/ca03a841088331505e942d73964347276323ab00_lg.jpg", @"large", 
          @"http://s3.amazonaws.com/dellerbie-places-food-images/ca03a841088331505e942d73964347276323ab00_sm.jpg", @"thumb",nil], @"avatar",
      nil];
      
  NSDictionary *p4 = [NSMutableDictionary 
    dictionaryWithObjectsAndKeys:
      @"Blue Moon", @"name", 
      @"bluemoon5", @"username",
      @"ghi1234", @"id", 
      [NSDictionary 
        dictionaryWithObjectsAndKeys:
          @"http://s3.amazonaws.com/dellerbie-places-food-images/ac525d94883c212256cae0e80577cddc50d0c88b_lg.jpg", @"large", 
          @"http://s3.amazonaws.com/dellerbie-places-food-images/ac525d94883c212256cae0e80577cddc50d0c88b_sm.jpg", @"thumb",nil], @"avatar",
      nil];
    
  NSDictionary *p5 = [NSMutableDictionary 
    dictionaryWithObjectsAndKeys:
      @"Jimi Hendrix", @"name", 
      @"jamesmarshall", @"username",
      @"tuv1234", @"id", 
      [NSDictionary 
        dictionaryWithObjectsAndKeys:
          @"http://s3.amazonaws.com/dellerbie-places-nyc/f84a73edfefc8af3234749e30d72c15faf37e05e_lg.jpg", @"large", 
          @"http://s3.amazonaws.com/dellerbie-places-nyc/f84a73edfefc8af3234749e30d72c15faf37e05e_sm.jpg", @"thumb",nil], @"avatar",
      nil];
      
  GMProfile *profile1 = [[GMProfile alloc] initWithAttributes:p1];
  GMProfile *profile2 = [[GMProfile alloc] initWithAttributes:p2];
  GMProfile *profile3 = [[GMProfile alloc] initWithAttributes:p3];
  GMProfile *profile4 = [[GMProfile alloc] initWithAttributes:p4];
  GMProfile *profile5 = [[GMProfile alloc] initWithAttributes:p5];
  NSMutableArray *profiles = [NSMutableArray arrayWithObjects:profile1, profile2, profile3, profile4, profile5, nil];
  return profiles;
}

@end
