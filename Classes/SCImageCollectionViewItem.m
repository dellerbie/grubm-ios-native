//
//  SCImageCollectionViewItem.m
//  SSCatalog
//
//  Created by Sam Soffes on 5/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SCImageCollectionViewItem.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@implementation SCImageCollectionViewItem

#pragma mark - Accessors

@synthesize imageURL = _imageURL;

- (void)setImageURL:(NSURL *)url {
	_imageURL = url;
	
	if (_imageURL) {
		[self.imageView setImageWithURL:url placeholderImage:nil];
	} else {
		self.imageView.image = nil;
	}
}


#pragma mark - Initializer

- (id)initWithReuseIdentifier:(NSString *)aReuseIdentifier {
	if ((self = [super initWithStyle:SSCollectionViewItemStyleImage reuseIdentifier:aReuseIdentifier])) {
		self.imageView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
	}
  
  CATransition *animation = [CATransition animation];
    [animation setDelegate:self]; // optional
    [animation setType:@"flip"];
    [animation setSubtype:kCATransitionFromRight];
    [animation setDuration:0.5];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFillMode: @"extended"];
    [[self layer] addAnimation:animation forKey:@"reloadAnimation"];
  
  
	return self;
}


- (void)prepareForReuse {
	[super prepareForReuse];
	self.imageURL = nil;
}

@end
