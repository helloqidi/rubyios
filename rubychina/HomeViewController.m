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
#import "SVSegmentedControl.h"
#import "ReaderViewController.h"

@interface HomeViewController ()

//所有的话题
@property (nonatomic,retain) NSMutableArray *topics;
//已请求了第几页的数据
@property (nonatomic, assign) int lastPage;

@property (nonatomic, strong) TopicTableView *myTableView;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    
    [self initTitleView];
    
    //无数据时先隐藏
    self.tableView.hidden = YES;
    
    [self initRequestTopicData];
    
    [self initTableViewPullRefresh];
}

- (void)initTitleView
{
	SVSegmentedControl *navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"活跃", @"我的", nil]];
    navSC.textColor = [UIColor lightGrayColor];
    
    navSC.changeHandler = ^(NSUInteger newIndex) {
        [self changeSegment:newIndex];
    };
    self.navigationItem.titleView = navSC;
}

//segment切换
- (void)changeSegment:(NSUInteger )index
{
    if (index == 0) {
        self.tableView.hidden = NO;
        self.myTableView.hidden = YES;
    }
    if (index == 1) {
        self.tableView.hidden = YES;
        [self initMyTableView];
    }
}

//初始导航按钮
- (void)initBarButtonItems
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(sendAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"二维码" style:UIBarButtonItemStylePlain target:self action:@selector(qrcodeAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
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

//切换到“我的”tableView
- (void)initMyTableView
{
    if (self.myTableView == nil) {
        self.myTableView = [[TopicTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        self.myTableView.hidden = YES;
        [self.view addSubview:self.myTableView];
        
        [self requestMyTopicData];
    }
    self.myTableView.hidden = NO;
}

#pragma mark - data
//初始请求话题数据
- (void)initRequestTopicData
{
    [super showHUD:MESSAGE_REQUEST_LOADING];
    
    [[AFAppDotNetAPIClient sharedClient] getPath:URL_TOPIC_ACTIVE
                                      parameters:nil
                                        success:^(AFHTTPRequestOperation *operation, id JSON) {
                                            NSArray *jsonArray = (NSArray *) JSON;
                                            [self requestTopicDataFinish:jsonArray];
                                        }
                                        failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                            NSLog(@"error:%@",error);
                                            [super showHUDComplete:MESSAGE_REQUEST_FAIL];
                                        }];
}

//请求话题数据完成
- (void)requestTopicDataFinish:(NSArray *)jsonArray
{
    [super hideHUD];
    
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
    
    //显示tableView
    self.tableView.hidden = NO;
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


- (void)requestMyTopicData
{
    [super showHUD:MESSAGE_REQUEST_LOADING];
    
    NSString *path = [NSString stringWithFormat:URL_USER_TOPIC,MY_LOGIN];
    [[AFAppDotNetAPIClient sharedClient] getPath:path
                                      parameters:nil
                                         success:^(AFHTTPRequestOperation *operation, id JSON) {
                                             NSArray *jsonArray = (NSArray *) JSON;
                                             [self requestMyTopicDataFinish:jsonArray];
                                         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                             NSLog(@"error:%@",error);
                                             [super showHUDComplete:MESSAGE_REQUEST_FAIL];
                                         }];
    
}

- (void)requestMyTopicDataFinish:(NSArray *)jsonArray
{
    [super hideHUD];
    
    NSMutableArray *topics=[NSMutableArray arrayWithCapacity:jsonArray.count];
    for (NSDictionary *topicDic in jsonArray) {
        TopicModel *topicModel = [[TopicModel alloc] initWithAttributes:topicDic];
        [topics addObject:topicModel];
    }

    NSDictionary *userDic = [NSDictionary dictionaryWithObjectsAndKeys:MY_LOGIN,@"login",MY_AVATAR,@"avatar_url", nil];
    
    UserModel *user = [[UserModel alloc] initWithAttributes:userDic];

    for (TopicModel *topic in topics) {
        topic.user = user;
    }
    
    self.myTableView.tableData = topics;
    [self.myTableView reloadData];
}

#pragma mark - action
- (void)sendAction
{
    SendViewController *sendCtrl = [[SendViewController alloc] init];
    [self.navigationController pushViewController:sendCtrl animated:YES];
}

- (void)qrcodeAction
{
    ReaderViewController *readerCtrl = [[ReaderViewController alloc] init];
    [self.navigationController pushViewController:readerCtrl animated:YES];
}

#pragma mark - dealloc
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
