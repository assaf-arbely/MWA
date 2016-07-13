//
//  AuthModel.h
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthModel : NSObject

+ (id)sharedInstance;

- (void)authorizeWith:(NSString *)username
             password:(NSString *)pass
                  url:(NSString *)urlString
             callback:(void (^)(id responce, NSError * error))callback;

@end
