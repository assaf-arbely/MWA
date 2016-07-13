//
//  DataValidator.m
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import "DataValidator.h"

@implementation DataValidator

+ (BOOL)isUsernameValid:(NSString *)userName{
    if (userName != nil){
        if (userName.length > 0){
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isPasswordValid:(NSString *)password{
    if (password != nil){
        if (password.length > 0){
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isUrlValid:(NSString *)urlString{
    if (urlString != nil){
        if (urlString.length > 0){
            NSString *urlRegEx =
            @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
            NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
            return [urlTest evaluateWithObject:urlString];
        }
    }
    return NO;
}

@end
