//
//  ReplyTableView.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-11.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplyTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *tableData;

@end
