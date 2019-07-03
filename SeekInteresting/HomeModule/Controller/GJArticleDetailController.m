//
//  GJArticleDetailController.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/6/10.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJArticleDetailController.h"
#import "GJArticleDetailBtmView.h"
#import "GJHomeEventsModel.h"

@interface GJArticleDetailController () <UIWebViewDelegate>
@property (nonatomic, strong) GJArticleDetailBtmView *btmView;
@end

@implementation GJArticleDetailController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_btmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(self.btmView.height);
    }];
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
    [self showShadorOnNaviBar:NO];
    [self.view addSubview:self.btmView];
}

- (void)initializationNetWorking {
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 50 - NavBar_H)];
    web.backgroundColor = [UIColor whiteColor];
    web.delegate = self;
    NSURLRequest *request =  [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
    [web loadRequest:request];
    [self.view addSubview:web];
    [self.view.loadingView startAnimation];
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
    
    _btmView.blockClickButtonIdx = ^(NSInteger idx) {
        
    };
}

#pragma mark - Custom delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view.loadingView stopAnimation];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.view.loadingView stopAnimation];
}

#pragma mark - Getter/Setter
- (GJArticleDetailBtmView *)btmView {
    if (!_btmView) {
        _btmView = [[GJArticleDetailBtmView alloc] init];
    }
    return _btmView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
