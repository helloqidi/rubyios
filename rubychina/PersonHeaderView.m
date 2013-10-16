//
//  PersonHeaderView.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-16.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "PersonHeaderView.h"
#import "UIImageView+WebCache.h"


@implementation PersonHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"PersonHeaderView" owner:self options:nil] lastObject];
        [self addSubview:view];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //头像
    NSURL *avatarUrl = [NSURL URLWithString:self.user.avatarUrl];
    [self.avatarImage setImageWithURL:avatarUrl];
    
    //用户名
    self.loginLabel.text = self.user.login;
    
    //email
    self.emailLabel.text = self.user.email;
}
@end
