//
//  GMAppDelegate.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/12/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "GMAppDelegate.h"
#import "GMSplashViewController.h"
#import "GMSplashImagesStore.h"
#import "GMSplashNavigationController.h"

@implementation GMAppDelegate

NSString * const fbAppID = @"268045516576285";
NSString * const fbAccessTokenKey = @"FBAccessTokenKey";
NSString * const fbExpirationDateKey = @"FBExpirationDateKey";

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize facebook = _facebook;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [self setWindow: [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
  
  [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
  [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
  
  self.facebook = [[Facebook alloc] initWithAppId:fbAppID andDelegate:self];
  [self setupFacebook];
  
  GMSplashViewController *rootController = [[GMSplashViewController alloc] init];
  GMSplashNavigationController *navigationController = [[GMSplashNavigationController alloc] initWithRootViewController:rootController];
  [self setNavigationController: navigationController];
  [[self window] addSubview:navigationController.view];
  
  [[self window] makeKeyAndVisible];
  return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{
  return [self.facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 
{
  return [self.facebook handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
    [self.facebook extendAccessTokenIfNeeded];
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
  if([defaults objectForKey:fbExpirationDateKey] &&
      [defaults objectForKey:fbAccessTokenKey]) {
      self.facebook.accessToken = [defaults objectForKey:fbAccessTokenKey];
      self.facebook.expirationDate = [defaults objectForKey:fbExpirationDateKey];
  }
}

- (void)storeFacebookAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
  NSLog(@"storing FB auth data. accessToken: %@, expiresAt: %@", accessToken, expiresAt);
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:accessToken forKey:fbAccessTokenKey];
  [defaults setObject:expiresAt forKey:fbExpirationDateKey];
  [defaults synchronize];
}

- (void)fbDidLogin 
{
  NSLog(@"FB did login");
  [self storeFacebookAuthData:self.facebook.accessToken expiresAt:self.facebook.expirationDate];
}

- (void)fbDidNotLogin:(BOOL)cancelled
{
  NSLog(@"FB did not login");
}

-(void)fbDidLogout
{
  NSLog(@"FB did logout");
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults removeObjectForKey:fbAccessTokenKey];
  [defaults removeObjectForKey:fbExpirationDateKey];
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
