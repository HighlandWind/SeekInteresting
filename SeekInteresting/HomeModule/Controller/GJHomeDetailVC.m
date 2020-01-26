//
//  GJHomeDetailVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/25.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJHomeDetailVC.h"
#import "GJHomeEventsModel.h"
#import "GJHomeDetailBtmView.h"

@interface GJHomeDetailVC () <UIWebViewDelegate>
@property (nonatomic, strong) GJHomeDetailBtmView *btmView;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation GJHomeDetailVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.btmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        if (IPHONE_X) {
            make.height.mas_equalTo(79);
        }else {
            make.height.mas_equalTo(49);
        }
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.btmView.mas_top);
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
    self.title = _model.name;
    [self.view addSubview:self.btmView];
    [self.view addSubview:self.webView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    [self webWithURL:@"https://www.baidu.com/"];
}

#pragma mark - Request Handle
- (void)webWithURL:(NSString *)url {
    NSURLRequest *request =  [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.view.loadingView startAnimation];
    [_webView loadRequest:request];
}

#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    self.btmView.blockClickBtnIdx = ^(NSInteger idx) {
        if (idx == 0) {
            
        }else if (idx == 1) {
            
        }else if (idx == 2) {
            
        }else if (idx == 3) {
            
        }
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
- (GJHomeDetailBtmView *)btmView {
    if (!_btmView) {
        _btmView = [[GJHomeDetailBtmView alloc] init];
    }
    return _btmView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
