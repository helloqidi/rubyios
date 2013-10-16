//
//  PersonViewController.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-16.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "BaseViewController.h"
#import "UserModel.h"
#import "TopicTableView.h"

@interface PersonViewController : BaseViewController

@property (nonatomic, strong) UserModel *user;
@property (strong, nonatomic) IBOutlet TopicTableView *tableView;

@end
