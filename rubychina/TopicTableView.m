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
#import "TopicViewController.h"

@implementation TopicTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initView];
    }
    return self;
}

// 使用xib创建初始化调用
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initView];
}

- (void)initView
{
    [self setAllowsSelection:YES];
    
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
    static NSString *identifier=@"TopicCellIdentifier";
    TopicCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    TopicModel *topic=self.tableData[indexPath.row];
    cell.topic = topic;
    
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicModel *topic = self.tableData[indexPath.row];
    TopicViewController *topicCtrl = [[TopicViewController alloc] init];
    topicCtrl.topic = topic;
    [self.viewController.navigationController pushViewController:topicCtrl animated:YES];
}



@end
