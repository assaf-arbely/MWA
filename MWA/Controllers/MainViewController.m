//
//  MainViewController.m
//  MWA
//
//  Created by Vitalii Popruzhenko on 13.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    [_dateButton setTitle:[self getDateDay] forState:UIControlStateNormal];
}

- (NSString *)getDateDay{
    NSCalendar *calendarGregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendarGregorian components:NSCalendarUnitDay fromDate:[NSDate date]];
    NSInteger day = [dateComponents day];
    return [NSString stringWithFormat:@"%ld", (long)day];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)calendarAction:(id)sender {
}

- (IBAction)dateAction:(id)sender {
}

- (IBAction)addAction:(id)sender {
}

- (IBAction)userAction:(id)sender {
}

@end
