//
//  GMSuggestedFoodTagsViewController.h
//  Grubm
//
//  Created by Derrick Ellerbie on 6/20/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import <SSToolkit/SSPickerViewController.h>

@interface GMSuggestedFoodTagsViewController : SSPickerViewController

@property(nonatomic, strong) NSMutableSet *selectedKeys;

@end
