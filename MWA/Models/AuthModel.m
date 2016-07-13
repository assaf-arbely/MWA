//
//  AuthModel.m
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import "AuthModel.h"
#import "APIModel.h"
#import "DataValidator.h"

@implementation AuthModel

+ (id)sharedInstance {
    
    static AuthModel *authModel = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        authModel = [[self alloc] init];
    });
    
    return authModel;
}

- (void)authorizeWith:(NSString *)username
             password:(NSString *)pass
                  url:(NSString *)urlString
             callback:(void (^)(id responce, NSError * error))callback{
    
    if (![DataValidator isUsernameValid:username]){
        NSError *error = [[NSError alloc] initWithDomain:kBaseDomain
                                                    code:kWrongUsernameCode
                                                userInfo:@{NSLocalizedDescriptionKey: @"InvalidUsernamePassw".localized}];
        callback(nil,error);
        return;
    }
    
    if (![DataValidator isPasswordValid:pass]){
        NSError *error = [[NSError alloc] initWithDomain:kBaseDomain
                                                    code:kWrongUsernameCode
                                                userInfo:@{NSLocalizedDescriptionKey: @"InvalidUsernamePassw".localized}];
        callback(nil,error);
        return;
    }
    
    if (![DataValidator isUrlValid:urlString]){
        NSError *error = [[NSError alloc] initWithDomain:kBaseDomain
                                                    code:kWrongServerURLCode
                                                userInfo:@{NSLocalizedDescriptionKey: @"InvalidServerURL".localized}];
        callback(nil,error);
        return;
    }
    
    APIModel *model = [[APIModel alloc] init];
    [model POST_RequestWithURL:urlString restPath:@[@"CoreServices",@"V1",@"Login"] params:nil callback:callback];
    
}


@end
