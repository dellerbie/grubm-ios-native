//
//  GMGrubmAPIClient.h
//  Grubm
//
//  Created by Derrick Ellerbie on 6/19/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "AFHTTPClient.h"

@interface GMGrubmAPIClient : AFHTTPClient

+ (GMGrubmAPIClient *)sharedClient;

@end
