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
#import "SendViewController.h"

@interface HomeViewController ()

//所有的话题
@property (nonatomic,retain) NSMutableArray *topics;
//已请求了第几页的数据
@property (nonatomic, assign) int lastPage;

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
    
    //初始化相关变量
    self.lastPage = 0;
    self.topics = [NSMutableArray array];
    
    [self initBarButtonItems];
    
    [self initRequestTopicData];
    
    [self initTableViewPullRefresh];
}

- (void)initBarButtonItems
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(sendAction)];
    self.navigationItem.leftBarButtonItem =leftItem;
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
    [self initRequestTopicData];
    
    __weak HomeViewController *weakSelf = self;
    [weakSelf.tableView.pullToRefreshView stopAnimating];
}


#pragma mark - data
//初始请求话题数据
- (void)initRequestTopicData
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
    
    //追加数组
    [self.topics addObjectsFromArray:topics];
    self.tableView.tableData = self.topics;
    
    [self.tableView reloadData];
    
    //初始化页数
    self.lastPage += 1;
}

//滚动加载
- (void)insertRowAtBottom
{
    int thePage = self.lastPage + 1;
    NSString *lastPage = [NSString stringWithFormat:@"%i",thePage];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:lastPage,@"page", nil];
    
    [[AFAppDotNetAPIClient sharedClient] getPath:URL_TOPIC_ACTIVE
                                      parameters:params
                                         success:^(AFHTTPRequestOperation *operation, id JSON) {
                                             NSArray *jsonArray = (NSArray *) JSON;
                                             [self requestTopicDataFinish:jsonArray];
                                         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                             NSLog(@"error:%@",error);
                                         }];
    
    __weak HomeViewController *weakSelf = self;
    [weakSelf.tableView.infiniteScrollingView stopAnimating];
}

#pragma mark - action
- (void)sendAction
{
    SendViewController *sendCtrl = [[SendViewController alloc] init];
    [self.navigationController pushViewController:sendCtrl animated:YES];
}

#pragma mark - dealloc
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
