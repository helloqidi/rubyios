//
//  TopicViewController.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "TopicViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "TopicHeaderView.h"

@interface TopicViewController ()

@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) TopicHeaderView *topicHeaderView;

@end

@implementation TopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.topic.title;
    
    //无数据时先隐藏tableView
    self.tableView.hidden = YES;
    self.topicHeaderView = [[TopicHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 127)];
    
    
    [self requestTopicData];
}

- (void)requestTopicData
{
    NSString *path = [NSString stringWithFormat:URL_TOPIC_DETAIL,self.topic.id];
    [[AFAppDotNetAPIClient sharedClient] getPath:path
                                      parameters:nil
                                         success:^(AFHTTPRequestOperation *operation, id JSON) {
                                             NSDictionary *jsonDic = (NSDictionary *) JSON;
                                             [self requestTopicDataFinish:jsonDic];
                                         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                             NSLog(@"error:%@",error);
                                         }];

}

- (void)requestTopicDataFinish:(NSDictionary *)jsonDic
{
    TopicModel *topic = [[TopicModel alloc] initWithAttributes:jsonDic];
    self.topic = topic;
    
    //获得描述的高度
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont systemFontOfSize:17.0f], NSFontAttributeName,
                                          nil];
    CGRect frame = [self.topic.body boundingRectWithSize:CGSizeMake(304, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributesDictionary
                                            context:nil];
    CGSize size = frame.size;
    //重置高度
    //NSLog(@"::%.2f",self.topicHeaderView.height);
    self.topicHeaderView.height -= 26;
    self.topicHeaderView.height += size.height;
    //NSLog(@"--%.2f",self.topicHeaderView.height);
    
    //显示头部视图
    self.topicHeaderView.topic = self.topic;
    self.tableView.tableHeaderView = self.topicHeaderView;
    //显示tableView
    self.tableView.hidden = NO;
    
    self.tableView.tableData = self.topic.replies;
    [self.tableView reloadData];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
