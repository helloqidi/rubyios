//
//  TopicHeaderView.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "TopicHeaderView.h"
#import "UIImageView+WebCache.h"
#import "PersonViewController.h"
#import "UIUtils.h"
#import "WebViewController.h"
#import "NSString+URLEncoding.h"

@implementation TopicHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"TopicHeaderView" owner:self options:nil] lastObject];
        [self addSubview:view];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    //标题
    self.titleLabel.text = self.topic.title;
    
    //头像
    NSURL *avatarUrl = [NSURL URLWithString:self.topic.user.avatarUrl];
    [self.avatarImage setImageWithURL:avatarUrl];
    __block TopicHeaderView *this = self;
    self.avatarImage.touchBlock = ^{
        PersonViewController *userViewController = [[PersonViewController alloc] init];
        userViewController.user = this.topic.user;
        [this.viewController.navigationController pushViewController:userViewController animated:YES];
    };
    
    //描述
    self.bodyLabel = [[RTLabel alloc] initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+5, 304, 0)];
    self.bodyLabel.delegate = self;
    NSString *parseText = [UIUtils parseLink:self.topic.body];
    [self.bodyLabel setText:parseText];
    //获得高度(20是根据情况调整的高度)
    float contentHeight = self.bodyLabel.optimumSize.height+20;
    //重置高度
    self.bodyLabel.height = contentHeight;
    [self addSubview:self.bodyLabel];
}

#pragma mark - RTLabel delegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url {
    NSString *urlstring = [[url absoluteString] URLDecodedString];
    if ([urlstring hasPrefix:@"http"]) {
        
        WebViewController *webView = [[WebViewController alloc] initWithUrl:urlstring];
        [self.viewController.navigationController pushViewController:webView animated:YES];
    }
}

@end
