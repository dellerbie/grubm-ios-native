//
//  GMRegistrationViewController.m
//  Registration
//
//  Created by Derrick Ellerbie on 6/18/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "GMRegistrationViewController.h"

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
  NSLog(@"text field returns: %@", textField);
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
  NSLog(@"POST to service");
  
  // disable the button
  // show the activity indicator
  // post data to server
}

@end
