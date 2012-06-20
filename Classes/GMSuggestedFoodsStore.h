//
//  GMSuggestedFoodsStore.h
//  Grubm
//
//  Created by Derrick Ellerbie on 6/20/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMSuggestedFoodsStore : NSObject
{
  NSArray *allTags;
}

- (NSArray *) allTags;

+ (GMSuggestedFoodsStore *)sharedStore;

@end
