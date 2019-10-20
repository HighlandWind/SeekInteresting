//
//  GJBirthdayTimeView.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/20.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJBirthdayTimeView.h"
//#import "PGPickerView.h"
#import "PGDatePicker.h"

@interface GJBirthdayTimeView () <PGDatePickerDelegate>
@property (nonatomic, strong) PGDatePicker *pickerView;
@end

@implementation GJBirthdayTimeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pickerView = [[PGDatePicker alloc]initWithFrame:self.bounds];
        _pickerView.delegate = self;
        _pickerView.rowHeight = AdaptatSize(55);
        _pickerView.datePickerType = PGDatePickerTypeSegment;
        _pickerView.datePickerMode = PGDatePickerModeDate;
        _pickerView.lineBackgroundColor = APP_CONFIG.grayTextColor;
        _pickerView.textColorOfSelectedRow = APP_CONFIG.darkTextColor;
        _pickerView.showUnit = PGShowUnitTypeNone;
        _pickerView.textFontOfSelectedRow = [APP_CONFIG appAdaptFontOfSize:15];
        _pickerView.textFontOfOtherRow = [APP_CONFIG appAdaptFontOfSize:15];
        _pickerView.autoSelected = YES;
//        _pickerView.maximumDate = [NSDate date];
        [self addSubview:_pickerView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    self.selectDate = dateComponents;
}

@end
