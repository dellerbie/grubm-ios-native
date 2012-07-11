//
//  GMProfile.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/29/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMProfile.h"

@implementation GMProfile

@synthesize id = _id;
@synthesize name = _name;
@synthesize username = _username;
@synthesize largeAvatar = _largeAvatar;
@synthesize thumbAvatar = _thumbAvatar;

-(id)initWithAttributes:(NSDictionary *)attributes
{
  self = [super init];
  if(self) {
    self.id = [attributes valueForKeyPath:@"id"];
    self.name = [attributes valueForKeyPath:@"name"];
    self.username = [attributes valueForKeyPath:@"username"];
    NSDictionary *avatar = [attributes valueForKeyPath:@"avatar"];
    self.largeAvatar = [NSURL URLWithString:[avatar valueForKeyPath:@"large"]];
    self.thumbAvatar = [NSURL URLWithString:[avatar valueForKeyPath:@"thumb"]];
  }
  return self;
}

-(NSString *)description
{
  return [NSString 
    stringWithFormat:@"id:%@, name: %@, username:%@, largeAvatar:%@, thumbAvatar:%@", 
    self.id, self.name, self.username, self.largeAvatar, self.thumbAvatar];
}

@end
