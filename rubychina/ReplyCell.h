//
//  ReplyCell.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-11.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyModel.h"

@interface ReplyCell : UITableViewCell

@property (nonatomic, strong) ReplyModel *reply;

@property (strong, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UILabel *createAtLabel;
@end
