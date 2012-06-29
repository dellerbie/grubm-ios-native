//
//  GMProfilesTableViewController.h
//  Grubm
//
//  Created by Derrick Ellerbie on 6/29/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMProfilesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray *profiles;
@property(nonatomic, strong) UITableView *profilesTableView;

@end
