//
//  KeychainHelper.m
//  MWA
//
//  Created by Vitalii Popruzhenko on 12.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import "KeychainHelper.h"
#import "KeychainItemWrapper.h"

@implementation KeychainHelper

+(id)readToken{
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kKeychainIdentifier accessGroup:nil];
    return [keychain objectForKey:(id)kSecValueData];
}

+(void)storeToken:(id)object{
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kKeychainIdentifier accessGroup:nil];
    [keychain setObject:object forKey:(id)kSecValueData];
}

@end
