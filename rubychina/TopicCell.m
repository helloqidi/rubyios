//
//  TopicCell.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "TopicCell.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
#import "PersonViewController.h"

@implementation TopicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //对UIView使用xib
        UIView *cell = [[[NSBundle mainBundle] loadNibNamed:@"TopicCell" owner:self options:nil] lastObject];
        [self.contentView addSubview:cell];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //头像
    NSURL *avatarUrl = [NSURL URLWithString:self.topic.user.avatarUrl];
    [self.avatarImage setImageWithURL:avatarUrl];
    __block TopicCell *this = self;
    self.avatarImage.touchBlock = ^{
        PersonViewController *userViewController = [[PersonViewController alloc] init];
        userViewController.user = this.topic.user;
        [this.viewController.navigationController pushViewController:userViewController animated:YES];
    };
    
    //标题
    self.titleLabel.text = self.topic.title;
    
    //用户名
    self.loginLabel.text = self.topic.user.login;
    
    //创建时间
    self.createdAtLabel.text = [UIUtils formatRubyChinaString:self.topic.createdAt];
}

//- (void)setTopic:(TopicModel *)topic
//{
//
//}


@end
