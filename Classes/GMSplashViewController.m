//
//  GMSplashViewController.m
//  Grubm
//
//  Created by Derrick Ellerbie on 6/12/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "GMSplashViewController.h"
#import "SCImageCollectionViewItem.h"

@implementation GMSplashViewController

-(void)viewDidLoad
{
  [super viewDidLoad];
  [self setTitle: @"Grubm"];
  [[self collectionView] setExtremitiesStyle: SSCollectionViewExtremitiesStyleScrolling];
  
  [self createBottomToolbar];
}

-(void)createBottomToolbar
{
  [self.navigationController setToolbarHidden:NO];
  [self.navigationController.toolbar setBarStyle:UIBarStyleBlackOpaque];
  
  UIBarButtonItem *signUpButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Up" style:UIBarButtonItemStyleBordered target:self action:@selector(signUp)];
  UIBarButtonItem *loginButton = [[UIBarButtonItem alloc]   initWithTitle:@"Login" style:UIBarButtonItemStyleBordered target:self action:@selector(login)];
  UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
  [self setToolbarItems:[NSArray arrayWithObjects:loginButton, spaceItem, signUpButton, nil]];
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
  return 10;
}

-(NSUInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSUInteger)section
{
  return 50;
}

-(SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath
{
  static NSString *const itemIdentifier = @"itemIdentifier";
  
  SCImageCollectionViewItem *item = (SCImageCollectionViewItem *)[aCollectionView dequeueReusableItemWithIdentifier:itemIdentifier];
  
  if(item == nil) {
    item = [[SCImageCollectionViewItem alloc] initWithReuseIdentifier:itemIdentifier];
  }
  
  CGFloat size = 80.0f * [[UIScreen mainScreen] scale];
  NSInteger i = (50 * indexPath.section) + indexPath.row;
  [item setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.gravatar.com/avatar/%i?s=%0.f&d=identicon", i, size]]];
  
  return item;
}


#pragma mark - SSCollectionViewDelegate

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSUInteger)section 
{
	return CGSizeMake(80.0f, 80.0f);
}


- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath 
{
	NSString *title = [NSString stringWithFormat:@"You selected item %i in section %i!",
					   indexPath.row + 1, indexPath.section + 1];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil
										  cancelButtonTitle:@"Oh, awesome!" otherButtonTitles:nil];
	[alert show];
}


- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForHeaderInSection:(NSUInteger)section 
{
	return 40.0f;
}

@end
