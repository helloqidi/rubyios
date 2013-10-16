//
//  WebViewController.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-16.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "WebViewController.h"
#import "RegexKitLite.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (id)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        self.url = [url copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *regex = @"\\.(jpg)|(JPG)|(jpeg)|(JPEG)|(png)|(PNG)$";
    NSArray *matchArray = [self.url componentsMatchedByRegex:regex];
    NSURL *url = [NSURL URLWithString:self.url];
    //是图片
    if (matchArray.count > 0) {
        NSString *HTMLData =[NSString stringWithFormat:@"<img src='%@' />",url];
        [self.webView loadHTMLString:HTMLData baseURL:nil];
    //是网页
    }else{
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
    self.title = @"Loading...";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

#pragma mark - action
- (IBAction)goBack:(id)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (IBAction)goForward:(id)sender
{
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

- (IBAction)refresh:(id)sender
{
    [self.webView reload];
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}

#pragma mark - dealloc
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
