//
//  LoginViewModel.h
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginViewModelDelegate;
@interface LoginViewModel : NSObject
- (id)initWithDelegate:(id)delegate;
- (void)authorizeWith:(NSString *)username password:(NSString *)pass url:(NSString *)urlString;
@end

@protocol LoginViewModelDelegate <NSObject>
@optional
- (void)validUsernamePassword:(BOOL)isValid;
- (void)validServer:(BOOL)isValid;
- (void)receivedError:(NSError *)error;
- (void)success;
@end

