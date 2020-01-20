//
//  GJDiscoverController.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/4/29.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJDiscoverController.h"

@interface GJDiscoverController ()

@end

@implementation GJDiscoverController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    
}

- (void)initializationSubView {
    self.title = @"任务";
    self.view.backgroundColor = APP_CONFIG.appBackgroundColor;
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response


#pragma mark - Custom delegate


#pragma mark - Getter/Setter


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
