//
//  TopicHeaderView.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "TopicHeaderView.h"
#import "UIImageView+WebCache.h"

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
    
    //描述
    self.bodyLabel.text = self.topic.body;
}

@end
