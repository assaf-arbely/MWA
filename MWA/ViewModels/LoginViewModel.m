//
//  LoginViewModel.m
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import "LoginViewModel.h"
#import "AuthModel.h"
#import "UITextField+MWA.h"
#import "LoginViewController.h"

@interface LoginViewModel ()
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) AuthModel *model;
@end

@implementation LoginViewModel

+ (id)sharedInstanceWithViewController:(LoginViewController *)viewController {
    // this prevents duplicated instances and create a shared one
    
    static LoginViewModel *viewModel = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        viewModel = [[self alloc] initWithViewController:viewController];
    });
    
    return viewModel;
}

- (id) initWithViewController:(UIViewController *)viewController {
    self = [super init];
    
    if (self) {
        self.viewController = viewController;
        
        self.model = [AuthModel sharedInstance];
    }
    
    return self;
}

- (void)authorizeWith:(NSString *)username password:(NSString *)pass url:(NSString *)urlString{
    [self.model authorizeWith:username password:pass url:urlString callback:^(id responce, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_viewController isKindOfClass:[LoginViewController class]]){
                
                LoginViewController *loginViewController = (LoginViewController *)_viewController;
                
                [loginViewController.userNameTextField isValid:YES];
                [loginViewController.passwordTextField isValid:YES];
                [loginViewController.serverTextField isValid:YES];
                
                if (error){
                    if (error.code == kWrongUsernameCode){
                        [loginViewController.userNameTextField isValid:NO];
                        [loginViewController.passwordTextField isValid:NO];
                        
                        [loginViewController.errorMessageLabel setText:error.localizedDescription];
                    }
                    if (error.code == kWrongServerURLCode){
                        [loginViewController.serverTextField isValid:NO];
                        
                        [loginViewController.errorMessageLabel setText:error.localizedDescription];
                    }
                } else {
                    #warning TODO: Improve this part when API availible
                    MWALog(@"[%@] %@",NSStringFromClass([responce class]),responce);
                    NSDictionary *responceDictionary = (NSDictionary *)responce;
                    if (responceDictionary[@"Status"]){
                        id indicator = responceDictionary[@"Status"][@"SuccessIndicator"];
                        if ([indicator integerValue] == 1){
                            //Save token and dismiss Login Screen
                        } else {
                            //Handle errors
                        }
                    }
                    [self.viewController performSegueWithIdentifier:@"authorizedSegue" sender:nil];
                }
            } else {
                #warning TODO: Callback to User's ViewController (delegate?)
            }
        });
    }];
}

@end
