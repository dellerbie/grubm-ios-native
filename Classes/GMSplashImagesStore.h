//
//  GMSplashImagesStore.h
//  Grubm
//
//  Created by Derrick Ellerbie on 6/13/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMSplashImagesStore : NSObject
{
  NSDictionary *allImages;
}

- (NSDictionary *) allImages;

+ (GMSplashImagesStore *)sharedStore;

@end
