//
//  PersonViewController.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-16.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonHeaderView.h"
#import "TopicModel.h"

@interface PersonViewController ()

@property (nonatomic, strong) PersonHeaderView *personHeaderView;

//所有的话题
@property (nonatomic,retain) NSMutableArray *topics;

@end

@implementation PersonViewController

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
    
    self.title = self.user.login;
    
    //初始化变量
    self.topics = [NSMutableArray array];
    
    [self initViews];
    
    [self requestUserData];
    [self requestTopicData];
}

- (void)initViews
{
    //头部视图
    self.personHeaderView = [[PersonHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    self.personHeaderView.user = self.user;
    self.tableView.tableHeaderView = self.personHeaderView;
    
}

#pragma mark - data
- (void)requestUserData
{
    NSString *path = [NSString stringWithFormat:URL_USER_DETAIL,self.user.login];
    [[AFAppDotNetAPIClient sharedClient] getPath:path
                                      parameters:nil
                                         success:^(AFHTTPRequestOperation *operation, id JSON) {
                                             NSDictionary *jsonDic = (NSDictionary *) JSON;
                                             [self requestUserDataFinish:jsonDic];
                                         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                             NSLog(@"error:%@",error);
                                         }];
    
}

- (void)requestUserDataFinish:(NSDictionary *)jsonDic
{
    UserModel *user = [[UserModel alloc] initWithAttributes:jsonDic];
    self.user = user;
    
    for (TopicModel *topic in self.user.topics) {
        topic.user = self.user;
    }
    self.personHeaderView.emailLabel.text = self.user.email;
}


- (void)requestTopicData
{
    [super showHUD:MESSAGE_REQUEST_LOADING];
    
    NSString *path = [NSString stringWithFormat:URL_USER_TOPIC,self.user.login];
    [[AFAppDotNetAPIClient sharedClient] getPath:path
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
    for (TopicModel *topic in self.topics) {
        topic.user = self.user;
    }

    self.tableView.tableData = self.topics;
    [self.tableView reloadData];
}

#pragma mark - dealloc
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
