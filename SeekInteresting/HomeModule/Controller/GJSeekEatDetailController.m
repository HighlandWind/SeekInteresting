//
//  GJSeekEatDetailController.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/5/16.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJSeekEatDetailController.h"

@interface GJSeekEatDetailController ()

@end

@implementation GJSeekEatDetailController

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
    self.title = @"去哪里吃呢？";
    [self showShadorOnNaviBar:NO];
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
