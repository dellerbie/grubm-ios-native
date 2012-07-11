//
//  GMProfile.h
//  Grubm
//
//  Created by Derrick Ellerbie on 6/29/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMProfile : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *id;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, strong) NSURL *largeAvatar;
@property(nonatomic, strong) NSURL *thumbAvatar;

-(id)initWithAttributes:(NSDictionary *)attributes;

@end
