//
//  GMFollowButton.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/29/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMFollowButtonView.h"

@implementation GMFollowButton

@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize profileId = _profileId;
@synthesize button = _button;

- (id)initWithFrame:(CGRect)frame profileId:(NSString *) profileId
{
  self = [super initWithFrame:frame];
  if(self) {
    self.profileId = profileId;
    self.frame = frame;
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.titleLabel.textColor = [UIColor grayColor];
    self.button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.button addTarget:self action:@selector(followUser:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
  }

  return self;
}

- (void)followUser:(id)sender
{
  DLog(@"%@ profileId %@", self.button.titleLabel.text, self.profileId);
  // make a call to the API, show an activity indicator, hide the button
  // update the model inside of friendsUsingApp array
  // change the button state  
  
//  [self.activityIndicator startAnimating];
//  self.hidden = YES;
  [self toggle];
}

- (void)showFollowState
{
  [self showState:@"Follow"];
}

- (void)showFollowingState
{
  [self showState:@"Following"];
}

- (void)showState:(NSString *)state
{
  NSString *backgroundImage;
  if([state isEqualToString:@"Following"]) {
    backgroundImage = @"greenButton.png";
  } else {
    backgroundImage = @"blueButton.png";
  }

  [self.button setTitle:state forState:UIControlStateNormal];
  UIImage *buttonBackground = [[UIImage imageNamed:backgroundImage] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
  [self.button setBackgroundImage:buttonBackground forState:UIControlStateNormal];
  [self.button setBackgroundImage:buttonBackground forState:UIControlStateHighlighted];
}

- (void)toggle
{
  NSString *buttonTitle = self.button.titleLabel.text;
  NSString *newTitle = @"Following";
  
  if([buttonTitle isEqualToString:@"Following"]) {
    newTitle = @"Follow";
  }
  
  [self showState:newTitle];
}

@end
