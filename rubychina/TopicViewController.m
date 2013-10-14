//
//  TopicViewController.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicHeaderView.h"
#import "SVPullToRefresh.h"
#import "CommentView.h"
#import "AFHTTPRequestOperation.h"

@interface TopicViewController ()

@property (nonatomic, strong) TopicHeaderView *topicHeaderView;
@property (nonatomic, strong) CommentView *commentView;

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
    
    [self initViews];
    
    //监听键盘
    [self observeKeybord];
    //增加view手势
    [self viewTapGesture];
    
    [self requestTopicData];
}

- (void)initViews
{
    //无数据时先隐藏tableView
    self.tableView.hidden = YES;
    self.topicHeaderView = [[TopicHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 127)];
    
    
    //评论框
    self.commentView = [[CommentView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 45, ScreenWidth, 45)];
    [self.commentView.replyBtn addTarget:self action:@selector(saveReplyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commentView];
    
}

#pragma mark - data
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

//发布评论
- (void)postCommentData{
    NSString *path = [NSString stringWithFormat:URL_CREATE_REPLY,self.topic.id];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.commentView.commentField.text,
                                   @"body",
                                   MY_TOKEN,
                                   @"token", nil];
    
    [[AFAppDotNetAPIClient sharedClientNoJson] postPath:path
                                             parameters:params
                                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                    NSLog(@"return : %@",operation.responseString);
                                                    //注：此处ruby china 服务器返回的不是 json 格式数据。成功后返回的是字符串“true”
                                                    [self postCommentDataFinish:operation.responseString];
                                                }
                                                failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                                    NSLog(@"error:%@",error);
                                                }];
}

//评论完成
- (void)postCommentDataFinish:(id)responseData
{
    if ([responseData isEqualToString:@"true"]) {
        self.commentView.commentField.text =@"";
    }else{
        NSLog(@"error when save!");
    }
}


#pragma mark - action
- (void)saveReplyAction
{
    if ([self isValidatedContent] == NO) {
        return;
    }
    
    [self postCommentData];
}

#pragma mark - private
- (BOOL)isValidatedContent
{
    BOOL returnBool = NO;
    
    if (self.commentView.commentField.text.length == 0) {
        [self.commentView.commentField becomeFirstResponder];
        returnBool = NO;
    }else{
        returnBool = YES;
    }
    return returnBool;

}

#pragma mark - keyboard
//监听键盘
- (void)observeKeybord
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)notification
{
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [value CGRectValue];
    self.commentView.top = (ScreenHeight-frame.size.height-45);
}

- (void)keyboardWasHidden:(NSNotification*)notification
{
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [value CGRectValue];
    //动画效果
    self.commentView.top = (ScreenHeight-frame.size.height-45);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    //匀速运动
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.commentView.top = ScreenHeight-45;
    [UIView commitAnimations];
}

//给view增加单击手势，用于点击空白隐藏键盘
- (void)viewTapGesture
{
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.commentView.commentField resignFirstResponder];
}

#pragma mark - dealloc
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
