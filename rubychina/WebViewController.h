//
//  WebViewController.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-16.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSString *url;

@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;
- (IBAction)refresh:(id)sender;

- (id)initWithUrl:(NSString *)url;

@end
