//
//  GMSplashViewController.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/12/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "GMSplashViewController.h"
#import "SCImageCollectionViewItem.h"
#import <SSToolkit/SSLabel.h>
#import "GMSplashImagesStore.h"

@implementation GMSplashViewController

-(void)viewDidLoad
{
  [super viewDidLoad];
  [self setTitle: @"Grubm"];
  
  SSCollectionView *collectionView = [self collectionView];
  [collectionView setExtremitiesStyle: SSCollectionViewExtremitiesStyleScrolling];
  [collectionView setRowSpacing:2.0f];
  [collectionView setMinimumColumnSpacing:0.0f];
  [self createBottomToolbar];
  
  [[self navigationItem] setTitleView: [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]]];
}

-(void)createBottomToolbar
{
  [[self navigationController] setToolbarHidden:NO];
  //[[[self navigationController] toolbar] setBarStyle:UIBarStyleBlackOpaque];
  [[[self navigationController] toolbar] 
    setBackgroundImage:[UIImage imageNamed:@"navToolbarBackground.png"] 
    forToolbarPosition:UIToolbarPositionBottom 
    barMetrics:UIBarMetricsDefault];
  
  UIBarButtonItem *signUpButton = [[UIBarButtonItem alloc] 
    initWithTitle:@"Sign Up" 
    style:UIBarButtonItemStyleBordered 
    target:self 
    action:@selector(signUp)];
  
  [signUpButton setTintColor: [UIColor blackColor]];
    
  UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] 
    initWithTitle:@"Login" 
    style:UIBarButtonItemStyleBordered 
    target:self 
    action:@selector(login)];
    
  [loginButton setTintColor: [UIColor blackColor]];
    
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

- (UIView *)collectionView:(SSCollectionView *)aCollectionView viewForHeaderInSection:(NSUInteger)section 
{
  // this creates some padding between the navbar and the first row of images
  SSLabel *header = [[SSLabel alloc] 
    initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, [[self collectionView] rowSpacing])];
  header.text = @"";
  return header;
}

- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForHeaderInSection:(NSUInteger)section 
{
  return [[self collectionView] rowSpacing];
}

@end
