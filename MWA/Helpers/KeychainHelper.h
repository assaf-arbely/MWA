//
//  KeychainHelper.h
//  MWA
//
//  Created by Vitalii Popruzhenko on 12.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainHelper : NSObject

+(id)readToken;
+(void)storeToken:(id)object;

@end
