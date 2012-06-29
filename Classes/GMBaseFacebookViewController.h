//
//  GMBaseFacebookViewController.h
//  Grubm
//
//  Created by Derrick Ellerbie on 6/27/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "GMProfilesViewController.h"

@interface GMBaseFacebookViewController : GMProfilesViewController<FBSessionDelegate>

@property (nonatomic, strong) Facebook *facebook;

- (void)setupFacebook;
- (NSString *)fbAppID;
- (NSString *)fbAccessTokenKey;
- (NSString *)fbExpirationDateKey;

@end
