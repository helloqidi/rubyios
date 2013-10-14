//
//  HomeViewController.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "HomeViewController.h"
#import "TopicModel.h"
#import "SVPullToRefresh.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self requestTopicData];
    
    [self initTableViewPullRefresh];
}


- (void)initTableViewPullRefresh
{
    //处理iOS7的兼容问题
    float version = WXHLOSVersion();
    if (version >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    __weak HomeViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
}

//下拉
- (void)insertRowAtTop
{
    __weak HomeViewController *weakSelf = self;
    NSLog(@"up...");
    [weakSelf.tableView.pullToRefreshView stopAnimating];
}

//上拉
- (void)insertRowAtBottom
{
    __weak HomeViewController *weakSelf = self;
    NSLog(@"down...");
    [weakSelf.tableView.infiniteScrollingView stopAnimating];
}


//请求话题数据
- (void)requestTopicData
{
    [[AFAppDotNetAPIClient sharedClient] getPath:URL_TOPIC_ACTIVE
                                      parameters:nil
                                        success:^(AFHTTPRequestOperation *operation, id JSON) {
                                            NSArray *jsonArray = (NSArray *) JSON;
                                            [self requestTopicDataFinish:jsonArray];
                                        }
                                        failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                              NSLog(@"error:%@",error);
                                        }];
}

//请求话题数据完成
- (void)requestTopicDataFinish:(NSArray *)jsonArray
{
    NSMutableArray *topics=[NSMutableArray arrayWithCapacity:jsonArray.count];
    for (NSDictionary *topicDic in jsonArray) {
        TopicModel *topicModel = [[TopicModel alloc] initWithAttributes:topicDic];
        [topics addObject:topicModel];
    }
    
    self.tableView.tableData = topics;
    
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
