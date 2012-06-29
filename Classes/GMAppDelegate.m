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
#import "FBConnect.h"

@implementation GMAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize facebook = _facebook;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [self setWindow: [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
  [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
  [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
  
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

@end
