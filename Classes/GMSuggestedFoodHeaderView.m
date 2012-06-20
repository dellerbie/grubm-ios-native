//
//  GMSuggestedFoodHeaderView.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/20/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMSuggestedFoodHeaderView.h"

@implementation GMSuggestedFoodHeaderView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setText:@"In Grubm, you can follow your favorite foods via tags. Here are a few suggested tags to get you started. Pick as many as you want. Later, you can add your own tags."];
    [self setTextAlignment:UITextAlignmentCenter];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setFont:[UIFont systemFontOfSize:14.0f]];
    [self setTextColor:GM_BLUE_TEXT_COLOR];
  }
  return self;
}

@end
