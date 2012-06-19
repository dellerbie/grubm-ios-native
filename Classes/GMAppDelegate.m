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

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [self setWindow: [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
  
  [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
  
  GMSplashViewController *rootController = [[GMSplashViewController alloc] init];
  GMSplashNavigationController *navigationController = [[GMSplashNavigationController alloc] initWithRootViewController:rootController];
  [self setNavigationController: navigationController];
  [[self window] addSubview:navigationController.view];
  
  [[self window] makeKeyAndVisible];
  return YES;
}

@end
