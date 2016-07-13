//
//  MainViewController.h
//  MWA
//
//  Created by Vitalii Popruzhenko on 13.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *toolBarView;

@property (weak, nonatomic) IBOutlet UIButton *dateButton;

- (IBAction)calendarAction:(id)sender;
- (IBAction)dateAction:(id)sender;
- (IBAction)addAction:(id)sender;
- (IBAction)userAction:(id)sender;

@end
