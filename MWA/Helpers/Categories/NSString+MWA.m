//
//  NSString+MWA.m
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import "NSString+MWA.h"

@implementation NSString(MWA)

- (NSString*)nonWhiteCheck
{
    if (self.emptyCheck)
    {
        NSCharacterSet*		const set = [NSCharacterSet.whitespaceAndNewlineCharacterSet invertedSet];
        
        if ([self rangeOfCharacterFromSet:set].location != NSNotFound)
        {
            return self;
        }
    }
    return nil;
}

- (NSString*)emptyCheck
{
    if (self.classCheck.length > 0)
    {
        return self;
    }
    return nil;
}

- (NSString*)classCheck
{
    if ([self isKindOfClass:NSString.class])
    {
        return self;
    }
    return nil;
}

- (NSString*)localized
{
    return NSLocalizedString(self, @"");
}

- (id)urlEncoded {
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)self,NULL,
                                                                             (CFStringRef)@"!*’();:@&=$,/?%#[]",
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}
@end
