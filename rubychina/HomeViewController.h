//
//  HomeViewController.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TopicTableView.h"

@interface HomeViewController : BaseViewController

@property (strong, nonatomic) IBOutlet TopicTableView *tableView;

@end
