//
//  WebOAuthViewController.m
//  stackOverflowFellows
//
//  Created by drwizzard on 2/16/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "WebOAuthViewController.h"
#import <WebKit/WebKit.h>

@interface WebOAuthViewController () <WKNavigationDelegate>

@end

@implementation WebOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame ];
    
    [self.view addSubview:webView];
    webView.navigationDelegate =self;
    
    NSString *urlString = @"https://stackexchange.com/oauth/dialog?client_id=4290&scope=no_expiry&redirect_uri=https://stackexchange.com/oauth/login_success";
    NSURL *url = [NSURL URLWithString:urlString];
    [webView loadRequest: [NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURLRequest *requset = navigationAction.request;
    NSURL *url = requset.URL;
    
    if ( [url.description containsString:@"access_token"]){
        NSArray *components = [[url description] componentsSeparatedByString:@"="];
        NSString *token = components.lastObject;
        NSUserDefaults *userDeafaults = [NSUserDefaults standardUserDefaults];
        [userDeafaults setObject:token forKey:@"token"];
        [userDeafaults synchronize];
        
        [self dismissViewControllerAnimated:true completion:nil];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


@end
