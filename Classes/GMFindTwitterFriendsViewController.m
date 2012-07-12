//
//  GMFindTwitterFriendsViewController.m
//  Grubm
//
//  Created by Derrick Ellerbie on 7/11/12.
//  Copyright (c) 2012 Dellerbie, Inc. All rights reserved.
//

#import "GMFindTwitterFriendsViewController.h"
#import <Accounts/Accounts.h>
#import <Twitter/TWRequest.h>
#import "MBProgressHUD.h"

@implementation GMFindTwitterFriendsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self showFollowings];
}

- (void)showFollowings
{
  [self showActivityIndicator];

  // check if there's a twitter account identifier in NSUserDefaults
  // if not , then request access to a twitter account

  ACAccountStore *store = [[ACAccountStore alloc] init];
  ACAccountType *twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
  
  [store requestAccessToAccountsWithType:twitterAccountType withCompletionHandler:^(BOOL granted, NSError *error) {
    if(!granted) {
      DLog(@"User rejected access to the account");
      [[self navigationController] popViewControllerAnimated:YES];
    }
    else {
      NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
      if([twitterAccounts count] > 0) {
        // should display an action sheet to choose which account
        // and then store that account identifier into NSUserDefaults
        // but just use the first account for simplicity
        
        ACAccount *account;
        
        if([twitterAccounts count] > 1) {
          // show action sheet
          UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select a Twitter Account" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
          
          for(ACAccount *tempAccount in twitterAccounts) {
            [actionSheet addButtonWithTitle:[tempAccount username]];
          }
          
          [actionSheet showFromToolbar:[[self navigationController] toolbar]];
          [self hideActivityIndicator];
        } 
        else {
          account = [twitterAccounts lastObject];
          [self requestTwitterFriendsWithAccount:account];
        }
      }
    }
  }];

  self.profiles = [NSArray array];
  DLog(@"profiles => %@", self.profiles);
  [self.profilesTableView reloadData];
}

- (void)requestTwitterFriendsWithAccount:(ACAccount *)account
{
  DLog(@"Account => %@", account);
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  [params setObject:[account username] forKey:@"screen_name"];
  [params setObject:@"true" forKey:@"stringify_ids"];
  
  NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/friends/ids.json"];
  TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:params requestMethod:TWRequestMethodGET];
  [request setAccount:account];
  [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
    if(!responseData) {
      DLog(@"%@", error);
    }
    else {
      NSError *jsonError;
      NSMutableDictionary *friends = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
      if(friends) {
        DLog(@"Twitter friends => %@", [friends objectForKey:@"ids"]);
        NSArray *ids = [friends objectForKey:@"ids"];
        [self requestGrubmProfilesWithIds:ids];
      } 
      else {
        DLog(@"%@", jsonError);
      }
    }
    
    [self hideActivityIndicator];
  }];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
  if(buttonIndex == 0) {
    DLog(@"User canceled the twitter account selection");
  } else {
    [self showActivityIndicator];
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
    
    DLog(@"Twitter accounts: %@", twitterAccounts);
    
    NSInteger index = buttonIndex - 1;
    ACAccount *account = [twitterAccounts objectAtIndex:index];
    DLog(@"Selected account => %@", account);
    [self requestTwitterFriendsWithAccount:account];
  }
}

- (void)showActivityIndicator
{
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideActivityIndicator
{
  [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)requestGrubmProfilesWithIds:(NSArray *)ids
{
  NSString *idsForGrubm = [ids componentsJoinedByString:@","];
  DLog(@"Ids to send to Grubm API: %@", idsForGrubm);
  
  // [self setProfiles:profiles];
}


@end
