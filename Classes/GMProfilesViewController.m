//
//  GMProfilesTableViewController.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/29/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMProfilesViewController.h"
#import "GMFollowButtonView.h"
#import "GMProfile.h"
#import "UIImageView+AFNetworking.h"

@implementation GMProfilesViewController

@synthesize profiles = _profiles;
@synthesize profilesTableView = _profilesTableView;

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.profilesTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
  self.profilesTableView.backgroundColor = [UIColor whiteColor];
  self.profilesTableView.delegate = self;
  self.profilesTableView.dataSource = self;
  self.profilesTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.profilesTableView];
}

#pragma mark - UITableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if(self.profiles.count == 0) {
    return 1;
  } else {
    return self.profiles.count;
  }
}

#pragma mark - UITableView delegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  GMFollowButton *button;

  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if(!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGRect buttonFrame = CGRectMake(cell.frame.size.width - 75 - 20, 10, 80, 24);
    button = [[GMFollowButton alloc] initWithFrame:buttonFrame profileId:@""];
    [cell.contentView addSubview:button];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGFloat activityIndicatorX = (button.frame.origin.x + (button.frame.size.width/2)) - 10;
    activityIndicator.frame = CGRectMake(activityIndicatorX, 7, 30, 30);
    [cell.contentView addSubview:activityIndicator];
    button.activityIndicatorView = activityIndicator;
  } else {
    for(UIView *subview in cell.contentView.subviews) {
      if([subview isKindOfClass:[GMFollowButton class]]) {
        button = (GMFollowButton *)subview;
      }
    }
  }
  
  if([self.profiles count] == 0) {
    DLog(@"No friends");
    cell.textLabel.text = @"No profiles found.";
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.text = @"";
    cell.imageView.image = nil;
  } else {
    GMProfile *profile = [self.profiles objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = profile.username;
    cell.detailTextLabel.text = profile.name;
    [cell.imageView setImageWithURL:profile.thumbAvatar placeholderImage:[UIImage imageNamed:@"defaultUser.jpg"]];
    cell.imageView.frame = CGRectMake(0, 0, 40, 40);
    cell.imageView.bounds = CGRectMake(0, 0, 40, 40);
    button.profileId = profile.id;
    [button showFollowState];
  }
  
  return cell;
}

@end
