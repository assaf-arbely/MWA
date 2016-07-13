//
//  NSString+MWA.h
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(MWA)

- (NSString*)nonWhiteCheck;			// returns nil if all-white-or-newline
- (NSString*)emptyCheck;			// returns nil if empty
- (NSString*)classCheck;			// returns nil if not an NSString

- (NSString*)localized;             // convenince method for NSLocalizedString()

- (id)urlEncoded;                   // make url encoded value for NSString

@end
