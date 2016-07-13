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
@property (strong, nonatomic) AuthModel *model;
@property (nonatomic, strong) id <LoginViewModelDelegate> loginDelegate;
@end

@implementation LoginViewModel

- (id)initWithDelegate:(id)delegate {
    self = [super init];
    
    if (self) {
        self.loginDelegate = delegate;
        
        self.model = [AuthModel sharedInstance];
    }
    
    return self;
}

- (void)authorizeWith:(NSString *)username password:(NSString *)pass url:(NSString *)urlString{
    [self.model authorizeWith:username password:pass url:urlString callback:^(id responce, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{                
                if ([self safeDelegateCall:@selector(validUsernamePassword:)]){
                        [self.loginDelegate validUsernamePassword:YES];
                }
                
                if ([self safeDelegateCall:@selector(validServer:)]){
                    [self.loginDelegate validServer:YES];
                }
                
                if (error){
              
                    if (error.code == kWrongUsernameCode){
                        if ([self safeDelegateCall:@selector(validUsernamePassword:)]){
                            [self.loginDelegate validUsernamePassword:NO];
                        }
                    }
                    
                    if (error.code == kWrongServerURLCode){
                        if ([self safeDelegateCall:@selector(validUsernamePassword:)]){
                            [self.loginDelegate validServer:NO];
                        }
                    }
                    
                    if ([self safeDelegateCall:@selector(receivedError:)]){
                        [self.loginDelegate receivedError:error];
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
                    if ([self safeDelegateCall:@selector(success)]){
                        [self.loginDelegate success];
                    }
                }
        });
    }];
}

- (BOOL)safeDelegateCall:(SEL)selector{
    if (self.loginDelegate){
        if ([self.loginDelegate respondsToSelector:selector]){
            return YES;
        }
    }
    return NO;
}
@end
