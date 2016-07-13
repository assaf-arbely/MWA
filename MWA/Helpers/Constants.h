//
//  Constants.h
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#ifndef MWA_CONSTANTS_H
#define MWA_CONSTANTS_H

static NSString * const kBaseDomain = @"com.verint.mwa";

static NSString * const kKeychainIdentifier = @"com.verint.mwa.identifier";

static NSInteger const  kWrongUsernameCode = 100;
static NSInteger const  kWrongServerURLCode = 101;

#ifdef DEBUG

// Values for login form prefilling.

static NSString * const debugUserName   = @"ghivroni";
static NSString * const debugPassword   = @"password";
static NSString * const debugServerUrl  = @"http://mobile.verint.com/mwa";
#endif

#endif