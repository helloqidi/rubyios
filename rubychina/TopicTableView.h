//
//  TopicTableView.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *tableData;

@end
