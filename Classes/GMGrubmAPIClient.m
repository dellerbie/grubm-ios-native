//
//  GMGrubmAPIClient.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/19/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMGrubmAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kGMGrubmAPIBaseURLString = @"http://localhost:3000/v1/";

@implementation GMGrubmAPIClient

+ (GMGrubmAPIClient *)sharedClient
{
  static GMGrubmAPIClient *_sharedClient = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedClient = [[GMGrubmAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kGMGrubmAPIBaseURLString]];
    [_sharedClient setParameterEncoding:AFJSONParameterEncoding];
  });
  
  return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url  
{
  if((self = [super initWithBaseURL:url])) {
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
  }
  
  return self;
}

@end
