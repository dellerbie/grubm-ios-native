//
//  GMFindFacebookFriendsViewController.h
//  Grubm
//
//  Created by Derrick Ellerbie on 6/27/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMBaseFacebookViewController.h"

typedef enum apiCall {
  kGraphApiUserFriendsUsingApp
} apiCall;

@interface GMFindFacebookFriendsViewController : GMBaseFacebookViewController 
  <FBRequestDelegate, UITableViewDataSource, UITableViewDelegate>
{
  apiCall currentApiCall;
}

@property (nonatomic, strong) UITableView *friendsTableView;
@property(nonatomic, strong) NSMutableArray *friendsUsingApp;

@end
