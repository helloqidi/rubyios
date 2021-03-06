//
//  ReplyCell.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-11.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "ReplyCell.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
#import "PersonViewController.h"

@implementation ReplyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //对UIView使用xib
        UIView *cell = [[[NSBundle mainBundle] loadNibNamed:@"ReplyCell" owner:self options:nil] lastObject];
        [self.contentView addSubview:cell];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //头像
    NSURL *avatarUrl = [NSURL URLWithString:self.reply.user.avatarUrl];
    [self.avatarImage setImageWithURL:avatarUrl];
    __block ReplyCell *this = self;
    self.avatarImage.touchBlock = ^{
        PersonViewController *userViewController = [[PersonViewController alloc] init];
        userViewController.user = this.reply.user;
        [this.viewController.navigationController pushViewController:userViewController animated:YES];
    };
    
    //内容
    self.bodyLabel.text = self.reply.body;
    
    //用户名
    self.loginLabel.text = self.reply.user.login;
    
    //回复时间
    self.createAtLabel.text = [UIUtils formatRubyChinaString:self.reply.createdAt];
}
@end
