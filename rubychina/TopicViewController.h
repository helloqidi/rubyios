//
//  TopicViewController.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TopicModel.h"
#import "ReplyTableView.h"

@interface TopicViewController : BaseViewController

@property (nonatomic, strong) TopicModel *topic;

@property (strong, nonatomic) IBOutlet ReplyTableView *tableView;
@end
