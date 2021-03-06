//
//  LoginViewController.m
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import "LoginViewController.h"
#import "UITextField+MWA.h"

@interface LoginViewController ()

@property (nonatomic, strong) LoginViewModel *model;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *serverTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;

- (IBAction)loginAction:(id)sender;

@end

@implementation LoginViewController

+ (LoginViewController *)getController{
    
    //For SDK need separate bundle with own storyboard.
    //Call [self.storyboard instantiateViewControllerWithIdentifier:@"MWALoginViewController"] instead init
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    return loginViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController){
        [self.navigationController setNavigationBarHidden:YES];
    }
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg"]];
    
    [self setupUI];
    
    _model = [[LoginViewModel alloc] initWithDelegate:self];

#ifdef DEBUG
    //Fill text fields with predefined values from Constants.h
    [_userNameTextField setText:debugUserName];
    [_passwordTextField setText:debugPassword];
    [_serverTextField setText:debugServerUrl];
#endif
    
}

- (void)setupUI{
    //UI customization
    
    [_serverTextField setPlaceholder:@"Server".localized];
    [_serverTextField setPlaceholdeColor:[UIColor whiteColor]];
    [_serverTextField setIcon:[UIImage imageNamed:@"ic_server"]];
    [_serverTextField underline];
    
    [_passwordTextField setPlaceholder:@"Password".localized];
    [_passwordTextField setPlaceholdeColor:[UIColor whiteColor]];
    [_passwordTextField setIcon:[UIImage imageNamed:@"ic_password"]];
    [_passwordTextField underline];

    [_userNameTextField setPlaceholder:@"Username".localized];
    [_userNameTextField setPlaceholdeColor:[UIColor whiteColor]];
    [_userNameTextField setIcon:[UIImage imageNamed:@"ic_username"]];
    [_userNameTextField underline];
    
    _loginButton.layer.cornerRadius = 5.0f;
    _loginButton.layer.borderWidth = 1.0f;
    _loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [_loginButton setTitle:@"Login".localized forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:LOGIN_BTN_COLOR];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Actions

- (IBAction)loginAction:(id)sender {
    [_model authorizeWith:_userNameTextField.text password:_passwordTextField.text url:_serverTextField.text];
}

#pragma mark - LoginViewModel Delegate

- (void)validUsernamePassword:(BOOL)isValid;{
    [_userNameTextField isValid:isValid];
    [_passwordTextField isValid:isValid];
}

- (void)validServer:(BOOL)isValid{
    [_serverTextField isValid:isValid];
}

- (void)receivedError:(NSError *)error{
    [_errorMessageLabel setText:error.localizedDescription];
}

- (void)success{
    [self performSegueWithIdentifier:@"authorizedSegue" sender:nil];
}
@end
