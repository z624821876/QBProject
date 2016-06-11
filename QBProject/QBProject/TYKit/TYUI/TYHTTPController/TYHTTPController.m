//
//  TYHTTPController.m
//  UEProject
//
//  Created by QuincyYan on 16/5/10.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYHTTPController.h"
#import "TYHTTPViewModel.h"
#import "TYHTTPProgressBar.h"

@interface TYHTTPController () <UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) TYHTTPProgressBar *progressBar;

@property (nonatomic,strong) TYHTTPViewModel *viewModel;
@end

@implementation TYHTTPController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.progressBar];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    [RACObserve(self.viewModel, URL)
     subscribeNext:^(NSString *URL) {
         @strongify(self);
         [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URL]]];
    }];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.viewModel.leftBarButtons = @[[TYBarEntity entityWithDefaultReturnIconWithTitle:title]];
    [self.progressBar stopProgressing];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.progressBar startProgressing];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        [_webView scalesPageToFit];
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

- (TYHTTPProgressBar *)progressBar {
    if (!_progressBar) {
        _progressBar = [[TYHTTPProgressBar alloc] init];
        [_progressBar setFrame:CGRectMake(0, 0, kScreenW, 5)];
    }
    return _progressBar;
}

@end
