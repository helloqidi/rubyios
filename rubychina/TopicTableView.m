//
//  TopicTableView.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "TopicTableView.h"
#import "TopicModel.h"
#import "TopicCell.h"

@implementation TopicTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

// 使用xib创建初始化调用
- (void)awakeFromNib
{
    [self initView];
}

- (void)initView
{
    self.dataSource = self;
    self.delegate = self;
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"TopicCell";
    TopicCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    TopicModel *topic=self.tableData[indexPath.row];
    cell.topic = topic;
    //cell.textLabel.text = topic.title;
    
    return cell;
}

@end
