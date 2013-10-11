//
//  TopicViewController.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@interface TopicViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TopicModel *topic;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
