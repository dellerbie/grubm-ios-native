//
//  GMBaseFacebookViewController.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/27/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMBaseFacebookViewController.h"

@implementation GMBaseFacebookViewController

@synthesize facebook = _facebook;

-(void)viewDidLoad
{
  [super viewDidLoad];
  self.facebook = [[Facebook alloc] initWithAppId:[self fbAppID] andDelegate:self];
  [self setupFacebook];
}

- (NSString *)fbAppID
{
  return @"268045516576285";
}

- (NSString *)fbAccessTokenKey
{
  return @"FBAccessTokenKey";
}

- (NSString *)fbExpirationDateKey
{
  return @"FBExpirationDateKey";
}

# pragma mark - Facebook Session Delegate

- (void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
  NSLog(@"extended FB token");
  [self storeFacebookAuthData:accessToken expiresAt:expiresAt];
}

- (void)setupFacebook
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  if([defaults objectForKey:[self fbExpirationDateKey]] &&
      [defaults objectForKey:[self fbAccessTokenKey]]) {
      self.facebook.accessToken = [defaults objectForKey:[self fbAccessTokenKey]];
      self.facebook.expirationDate = [defaults objectForKey:[self fbExpirationDateKey]];
  }
}

- (void)storeFacebookAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
  NSLog(@"storing FB auth data. accessToken: %@, expiresAt: %@", accessToken, expiresAt);
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:accessToken forKey:[self fbAccessTokenKey]];
  [defaults setObject:expiresAt forKey:[self fbExpirationDateKey]];
  [defaults synchronize];
}

- (void)fbDidLogin 
{
  NSLog(@"FB did login");
  [self storeFacebookAuthData:self.facebook.accessToken expiresAt:self.facebook.expirationDate];
  
  // post FB id to user's profile in Grubm
}

- (void)fbDidNotLogin:(BOOL)cancelled
{
  NSLog(@"FB did not login");
}

-(void)fbDidLogout
{
  NSLog(@"FB did logout");
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults removeObjectForKey:[self fbAccessTokenKey]];
  [defaults removeObjectForKey:[self fbExpirationDateKey]];
  [defaults synchronize];
}

- (void)fbSessionInvalidated
{
  UIAlertView *alertView = [[UIAlertView alloc]
    initWithTitle:@"Auth Exception"
    message:@"Your session has expired."
    delegate:nil
    cancelButtonTitle:@"OK"
    otherButtonTitles:nil,
    nil];
  [alertView show];
  [self fbDidLogout];
}


@end
