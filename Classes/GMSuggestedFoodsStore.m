//
//  GMSuggestedFoodsStore.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/20/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMSuggestedFoodsStore.h"

@implementation GMSuggestedFoodsStore

+ (id)allocWithZone:(NSZone *)zone
{
  return [self sharedStore];
}

+ (GMSuggestedFoodsStore *)sharedStore
{
  static GMSuggestedFoodsStore * sharedStore = nil;
  if(!sharedStore) {
    sharedStore = [[super allocWithZone:nil] init];
  }
  return sharedStore;
}

- (id) init 
{
  self = [super init];
  if(self) {
    NSString *error = nil;
    NSPropertyListFormat format;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SuggestedFoodTags" ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    
    NSDictionary *plist = (NSDictionary *)[NSPropertyListSerialization
      propertyListFromData:plistXML 
      mutabilityOption:NSPropertyListImmutable 
      format:&format 
      errorDescription:&error];
    if(!plist) {
      DLog(@"Error reading plist: %@, format: %d", error, format);
    }
    
    NSArray *unsortedTags = [plist valueForKey:@"tags"];
    allTags = [unsortedTags sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    DLog(@"tags: %@", allTags);
  }
  
  return self;
}

- (NSArray *)allTags
{
  return allTags;
}

@end
