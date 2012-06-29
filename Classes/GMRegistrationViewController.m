//
//  GMRegistrationViewController.m
//  Registration
//
//  Created by Derrick Ellerbie on 6/18/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "GMRegistrationViewController.h"
#import "GMSuggestedFoodTagsViewController.h"
#import "GMGrubmAPIClient.h"
#import <SSToolkit/SSHUDView.h>
#import "AFJSONRequestOperation.h"
#import "MBProgressHUD.h"

typedef void(^RegistrationSuccessBlock)(AFHTTPRequestOperation *operation, id JSON);
typedef void(^RegistrationFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface GMRegistrationViewController()

-(RegistrationSuccessBlock)registrationSuccess;
-(RegistrationFailureBlock)registrationFailure;

@end

@implementation GMRegistrationViewController

@synthesize usernameCell, emailCell, passwordCell, passwordConfirmationCell;
@synthesize usernameTextField, emailTextField, passwordTextField, passwordConfirmationTextField;

- (void)viewDidLoad
{
  [super viewDidLoad];
  UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(register:)];
  [[self navigationItem] setRightBarButtonItem: done];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell;
  switch (indexPath.row) {
    case 0:
      cell = [self emailCell];
      break;
    case 1:
      cell = [self usernameCell];
      break;
    case 2:
      cell = [self passwordCell];
      break;
    case 3:
      cell = [self passwordConfirmationCell];
      break;
  }
  return cell;
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  DLog(@"text field returns: %@", textField);
  [textField resignFirstResponder];
  
  if(textField == [self emailTextField]) {
    [[self usernameTextField] becomeFirstResponder];
  } else if(textField == [self usernameTextField]) {
    [[self passwordTextField] becomeFirstResponder];
  } else if(textField == [self passwordTextField]) {
    [[self passwordConfirmationTextField] becomeFirstResponder];
  } else {
    // post to server
    [self register:[[self navigationItem] rightBarButtonItem]];
  }
  
  return YES;
}

- (void)register:(id)sender
{
  DLog(@"POST to service");
  
  // dismiss the keyboard
  [[self view] resignFirstResponder];
  // disable the button
  [self toggleDoneButton];
  [self showActivityIndicator];
  
  NSDictionary *profile = [NSMutableDictionary dictionary];
  [profile setValue:[usernameTextField text] forKey:@"username"];
  [profile setValue:[emailTextField text] forKey:@"email"];
  [profile setValue:[passwordTextField text] forKey:@"password"];
  [profile setValue:[passwordConfirmationTextField text] forKey:@"password_confirmation"];

//  [[GMGrubmAPIClient sharedClient] 
//    postPath:@"profiles/sign_up" 
//    parameters:[NSDictionary dictionaryWithObject:profile forKey:@"profile"] 
//    success:[self registrationSuccess] 
//    failure:[self registrationFailure]];
  
  [self hideActivityIndicator];
  GMSuggestedFoodTagsViewController *foodTagsController = [[GMSuggestedFoodTagsViewController alloc] init];
  [[self navigationController] pushViewController:foodTagsController animated:YES];
}

-(RegistrationSuccessBlock)registrationSuccess
{
  RegistrationSuccessBlock success = ^(AFHTTPRequestOperation *operation, id JSON) {
      DLog(@"Success. JSON: %@", JSON);
      
      // dismiss the hud
      // set auth-token in keychain
      // set the pleaseRateAndReview count to 0 (every X times the app launches, show an alert view asking the user to rate & review the app)
      // hide the back button
      // show the "pick favorite foods to watch"
   };
   return success;
}

-(RegistrationFailureBlock)registrationFailure
{
  RegistrationFailureBlock failure = ^(AFHTTPRequestOperation *operation, NSError *error) {
      [self hideActivityIndicator];
      [self toggleDoneButton];
      NSDictionary *response = ((AFJSONRequestOperation *)operation).responseJSON;
      DLog(@"Response: %@", response);
      
      if(response && [response valueForKey:@"errors"]) {
        NSDictionary *errors = [response valueForKey:@"errors"];
        DLog(@"%@", errors);
        
        NSMutableString *errorString = [NSMutableString string];
        for(NSString *key in [errors keyEnumerator]) {
          DLog(@"error on key: %@", key);
          NSArray *errorsOnKey = [errors valueForKey:key];
          [errorString appendString:[NSString stringWithFormat:@"%@: %@\n", [key capitalizedString], [errorsOnKey componentsJoinedByString:@", "]]];
        }
        
        DLog(@"Error String: %@", errorString);
        [[[UIAlertView alloc] initWithTitle:@"Error" 
          message:errorString 
          delegate:nil 
          cancelButtonTitle:nil 
          otherButtonTitles:@"Ok", 
          nil] show];
      } else {
        [[[UIAlertView alloc] initWithTitle:@"Error" 
          message:@"Could not register you at this time. Please try again later." 
          delegate:nil 
          cancelButtonTitle:nil 
          otherButtonTitles:@"Ok", 
          nil] show];
      }
   };
   return failure;
}

- (void)toggleDoneButton
{
  UIBarButtonItem *done = [[self navigationItem] rightBarButtonItem];
  [done setEnabled:(![done isEnabled])];
}

- (void)showActivityIndicator
{
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideActivityIndicator
{
  [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
