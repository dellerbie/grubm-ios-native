//
//  GMSplashImagesStore.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/13/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMSplashImagesStore.h"

@implementation GMSplashImagesStore

- (id) init 
{
  self = [super init];
  if(self) {
    NSString *error = nil;
    NSPropertyListFormat format;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SplashImages" ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    
    allImages = (NSDictionary *)[NSPropertyListSerialization
      propertyListFromData:plistXML 
      mutabilityOption:NSPropertyListImmutable 
      format:&format 
      errorDescription:&error];
    if(!allImages) {
      DLog(@"Error reading plist: %@, format: %d", error, format);
    }
  }
  
  return self;
}

- (NSDictionary *)allImages
{
  return allImages;
}

+ (id)allocWithZone:(NSZone *)zone
{
  return [self sharedStore];
}

+ (GMSplashImagesStore *)sharedStore
{
  static GMSplashImagesStore * sharedStore = nil;
  if(!sharedStore) {
    sharedStore = [[super allocWithZone:nil] init];
  }
  return sharedStore;
}

@end
