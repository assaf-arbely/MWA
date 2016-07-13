//
//  DataValidator.h
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataValidator : NSObject

+ (BOOL)isUsernameValid:(NSString *)userName;
+ (BOOL)isPasswordValid:(NSString *)password;
+ (BOOL)isUrlValid:(NSString *)urlString;
@end
