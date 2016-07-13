//
//  LoginViewController.h
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"

@interface LoginViewController : UITableViewController <UITextFieldDelegate, LoginViewModelDelegate>

+ (LoginViewController *)getController;

@end
