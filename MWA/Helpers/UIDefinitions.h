//
//  UIDefinitions
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//
#define RGB_COLOR(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]

#pragma mark - COLORS 
//link to UX specification for colors

#pragma mark PRIMARY APP COLORS

#define VERINT_BRANDING_COLOR                 RGB_COLOR(193,215,153,1)

#pragma mark SPECIAL USE APP COLORS

#define LOGIN_BTN_COLOR                 RGB_COLOR(42,93,147,1)
#define INVALID_TXT_FIELD_COLOR         RGB_COLOR(237,132,135,1)

#pragma mark - FONTS
//link to UX specification for fonts

#define F1_FONT                             [UIFont fontWithName:@"HelveticaNeue" size:18]

#pragma mark - IMAGES
//Any hardcoded image names