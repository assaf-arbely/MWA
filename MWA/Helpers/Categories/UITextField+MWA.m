//
//  UITextField+MWA.m
//  MWA
//
//  Created by Vitalii Popruzhenko on 12.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import "UITextField+MWA.h"

static NSInteger textOffset = 12.0f;        //Offset from Icon to text
static NSInteger underlineWidth = 1.0f;     //Width of line under text field

@implementation UITextField (MWA)

- (void)setIcon:(UIImage *)iconImage{
    //Creating container for Icon
    UIView *textFieldContainer = [[UIView alloc] init];
    
    [textFieldContainer setFrame:CGRectMake(0.0f, 0.0f, iconImage.size.height+textOffset, iconImage.size.height)];
    
    [textFieldContainer setBackgroundColor:[UIColor clearColor]];
    
    //Creating UIImageView fro Icon
    UIImageView *icon = [[UIImageView alloc] init];
    [icon setImage:iconImage];
    [icon setFrame:CGRectMake(0, 0, iconImage.size.width, iconImage.size.height)];
    [icon setBackgroundColor:[UIColor clearColor]];
    
    [textFieldContainer addSubview:icon];
    
    //Setting Container to TextField
    [self setLeftView:textFieldContainer];
    [self setLeftViewMode:UITextFieldViewModeAlways];
}
- (void)setPlaceholdeColor:(UIColor *)color{
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        //This can happen only if iOS older or 6.0, which is impossible as minimum required version for MWA is 8.0
        MWALog(@"Cannot set placeholder text's color");
    }
}

- (void)underline{
    
    CALayer *border = [self layerByTag:@"underlineLayer"];
    if (border){
        [border removeFromSuperlayer];
    }
    
    border = [CALayer layer];
    CGFloat borderWidth = underlineWidth;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    [self.layer setValue:border forKey:@"underlineLayer"];
}

- (void)isValid:(BOOL)valid{
    CALayer *square = [self layerByTag:@"redLayer"];
    if (square){
        [square removeFromSuperlayer];
    }
    if (!valid){
        square = [CAShapeLayer layer];
        
        //TODO: In case of problems for other devices excep iPhone, redevelop this frame calculation
        CGRect frame = self.bounds;
        frame.origin.x += self.leftView.frame.size.width;
        frame.size.width -= self.leftView.frame.size.width;
        frame.size.height -= self.frame.size.height/3;
        frame.origin.y += frame.size.height/4;
        
        square.frame = frame;
        [square setBackgroundColor:INVALID_TXT_FIELD_COLOR.CGColor];
        [self.layer insertSublayer:square atIndex:1];
        [self.layer setValue:square forKey:@"redLayer"];
    }
}

- (CALayer *)layerByTag:(NSString *)name{
    return [self.layer valueForKey:name];
}

@end
