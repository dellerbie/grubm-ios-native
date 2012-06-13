//
//  GMSplashViewController.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/12/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "GMSplashViewController.h"
#import "SCImageCollectionViewItem.h"
#import "GMSplashImagesStore.h"

@implementation GMSplashViewController

-(void)viewDidLoad
{
  [super viewDidLoad];
  [self setTitle: @"Grubm"];
  [[self collectionView] setExtremitiesStyle: SSCollectionViewExtremitiesStyleScrolling];
  [[self collectionView] setRowSpacing:2.0f];
  [[self collectionView] setMinimumColumnSpacing:0.0f];
  [self createBottomToolbar];
}

-(void)createBottomToolbar
{
  [self.navigationController setToolbarHidden:NO];
  [self.navigationController.toolbar setBarStyle:UIBarStyleBlackOpaque];
  
  UIBarButtonItem *signUpButton = [[UIBarButtonItem alloc] 
    initWithTitle:@"Sign Up" 
    style:UIBarButtonItemStyleBordered 
    target:self 
    action:@selector(signUp)];
    
  UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] 
    initWithTitle:@"Login" 
    style:UIBarButtonItemStyleBordered 
    target:self 
    action:@selector(login)];
    
  UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] 
    initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
    target:nil 
    action:NULL];
    
  UIBarButtonItem *spaceItem2 = [[UIBarButtonItem alloc] 
    initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
    target:nil 
    action:NULL];
    
  [self setToolbarItems:[NSArray 
    arrayWithObjects:spaceItem, signUpButton, loginButton, spaceItem2, nil]];
}

-(void)signUp
{
  NSLog(@"sign up clicked");
}

-(void)login
{
  NSLog(@"login clicked");
}

-(NSUInteger)numberOfSectionsInCollectionView:(SSCollectionView *)aCollectionView
{
  return 1;
}

-(NSUInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSUInteger)section
{
  return 20;
}

-(SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath
{
  static NSString *const itemIdentifier = @"itemIdentifier";
  SCImageCollectionViewItem *item = (SCImageCollectionViewItem *)[aCollectionView 
    dequeueReusableItemWithIdentifier:itemIdentifier];
  
  if(item == nil) {
    item = [[SCImageCollectionViewItem alloc] initWithReuseIdentifier:itemIdentifier];
  }
  
  NSDictionary *images = [[GMSplashImagesStore sharedStore] allImages];
  NSUInteger randomKeyIndex = arc4random() % [images count];
  NSString *typeOfFood = [[images allKeys] objectAtIndex:randomKeyIndex];
  
  NSArray *burgers = [[[GMSplashImagesStore sharedStore] allImages] objectForKey:typeOfFood];
  NSInteger index = (20 * indexPath.section) + indexPath.row;
  [item setImageURL:[NSURL URLWithString:[burgers objectAtIndex:index]]];
  
  return item;
}

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSUInteger)section 
{
	return CGSizeMake(75.0f, 75.0f);
}

@end
