//
//  GJHomeDetailCVCell.m
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/26.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJHomeDetailCVCell.h"
#import "GJHomeEventsModel.h"

@interface GJHomeDetailCVCell () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation GJHomeDetailCVCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.webView];
    }
    return self;
}

- (void)setModel:(GJHomeEventsDetailModel *)model {
    _model = model;
//    [self webWithURL:model];
    [self webWithContent:model];
}

- (void)webWithContent:(GJHomeEventsDetailModel *)model {
    NSString *title = [NSString stringWithFormat:@"<h2>%@</h2>", model.title];
    NSString *desc = JudgeContainerCountIsNull(model.media) ? @"" : [NSString stringWithFormat:@"%@&nbsp;&nbsp;", model.media];
    NSString *time = [NSString stringWithFormat:@"%@</br></br>", model.time];
    
    NSMutableString *images = @"".mutableCopy;
    if (model.data.count > 0) {
        [model.data enumerateObjectsUsingBlock:^(GJHomeEventsData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [images appendFormat:@"%@</br><img src=\"%@\" width=\"%f\"></br></br>", obj.desc, obj.url, SCREEN_W - 20];
        }];
    }
    
    NSString *content = [NSString stringWithFormat:@"%@%@%@%@</br>%@</br></br></br></br>", title, desc, time, model.content, images];
    [_webView loadHTMLString:content baseURL:nil];
}

- (void)webWithURL:(NSString *)url {
    NSURLRequest *request =  [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.loadingView startAnimation];
    [_webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingView stopAnimation];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.loadingView stopAnimation];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
    }
    return _webView;
}

@end
