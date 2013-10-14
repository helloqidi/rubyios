//
//  TopicCell.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@interface TopicCell : UITableViewCell

@property (nonatomic, strong) TopicModel *topic;

@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *loginLabel;

@property (strong, nonatomic) IBOutlet UILabel *createdAtLabel;
@end
