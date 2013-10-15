//
//  SendViewController.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-14.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NodeSelectViewController.h"
#import "TPKeyboardAvoidingTableView.h"

@interface SendViewController : UIViewController <UITableViewDataSource,UITabBarDelegate,NodeSelectDelegate>
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;

@end
