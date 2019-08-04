//
//  GJBaseTableView.h
//  ZHYK
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJBaseTableView : UITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style controller:(UIViewController <UITableViewDelegate, UITableViewDataSource>*)context;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style view:(UIView <UITableViewDelegate, UITableViewDataSource>*)context;

@end
