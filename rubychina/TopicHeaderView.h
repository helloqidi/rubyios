//
//  TopicHeaderView.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
#import "InterfaceImageView.h"
#import "RTLabel.h"

@interface TopicHeaderView : UIView <RTLabelDelegate>

@property (nonatomic, strong) TopicModel *topic;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet InterfaceImageView *avatarImage;

@property (nonatomic, strong) RTLabel *bodyLabel;

@end
