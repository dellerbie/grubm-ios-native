//
//  GMFollowButton.h
//  Grubm
//
//  Created by Derrick Ellerbie on 6/29/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMFollowButton : UIView

@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic, copy) NSString *profileId;
@property(nonatomic, strong) UIButton *button;

- (id)initWithFrame:(CGRect)frame profileId:(NSString *) profileId;
- (void)showFollowState;
- (void)showFollowingState;
- (void)toggle;

@end
