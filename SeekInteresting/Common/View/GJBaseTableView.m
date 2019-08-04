//
//  GJBaseTableView.m
//  ZHYK
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseTableView.h"

@interface GJBaseTableView ()

@end

@implementation GJBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style controller:(UIViewController<UITableViewDelegate,UITableViewDataSource> *)context {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = context;
        self.dataSource = context;
        self.sectionHeaderHeight = 0.01;
        self.sectionFooterHeight = 0.01;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedRowHeight = 0;
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style view:(UIView<UITableViewDelegate,UITableViewDataSource> *)context {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = context;
        self.dataSource = context;
        self.sectionHeaderHeight = 0.01;
        self.sectionFooterHeight = 0.01;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedRowHeight = 0;
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    }
    return self;
}

@end
