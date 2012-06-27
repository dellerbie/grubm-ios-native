//
//  UITableView+ReloadWithAnimation.h
//  Grubm
//
//  Created by Derrick Ellerbie on 6/20/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SSToolkit/SSCollectionView.h>

@interface SSCollectionView (ReloadWithAnimation)

- (void)reloadData:(BOOL)animated;

@end
