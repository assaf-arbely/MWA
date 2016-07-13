//
//  UITextField+MWA.h
//  MWA
//
//  Created by Vitalii Popruzhenko on 12.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (MWA)

- (void)setIcon:(UIImage *)iconImage;           //Set custom Icon at left side of text field
- (void)setPlaceholdeColor:(UIColor *)color;    //Set custom color of placeholder
- (void)underline;                              //Draw line under text field
- (void)isValid:(BOOL)valid;                    //Highlight/Unhighlight text field with specific color 

@end
