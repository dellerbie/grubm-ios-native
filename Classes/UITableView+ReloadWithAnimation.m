//
//  UITableView+ReloadWithAnimation.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/20/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "UITableView+ReloadWithAnimation.h"
#import <QuartzCore/QuartzCore.h>

@implementation SSCollectionView (ReloadWithAnimation)

- (void)reloadData:(BOOL)animated
{
  [self reloadData];
  if (animated) {
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self.delegate]; // optional
    [animation setType:@"flip"];
    [animation setSubtype:kCATransitionFromRight];
    [animation setDuration:0.5];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFillMode: @"extended"];
    [[self layer] addAnimation:animation forKey:@"reloadAnimation"];
  }
}

@end
