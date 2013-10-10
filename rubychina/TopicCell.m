//
//  TopicCell.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "TopicCell.h"
#import "UIImageView+WebCache.h"

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
    
    //标题
    self.titleLabel.text = self.topic.title;

}

@end
