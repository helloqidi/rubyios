//
//  SendViewController.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-14.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "SendViewController.h"
#import "AFHTTPRequestOperation.h"

@interface SendViewController ()

@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextView *bodyTextView;
@property (nonatomic, strong) NodeModel *selectedNode;
@property (nonatomic, strong) UILabel *selectedNodeLabel;

@end

@implementation SendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"发布新帖";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.selectedNode = nil;
    
    [self initBarButtonItems];
    
}


- (void)initBarButtonItems
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveTopicAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - data
- (void)postTopicData
{
    [super showHUD:MESSAGE_REQUEST_COMMIT];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.titleField.text,
                                   @"title",
                                   self.bodyTextView.text,
                                   @"body",
                                   self.selectedNode.id,
                                   @"node_id",
                                   MY_TOKEN,
                                   @"token", nil];
    
    
    //暂时先不上传，为了保证网站内容质量
    NSLog(@"%@",params);
    [super hideHUD];
    [self.navigationController popViewControllerAnimated:YES];
    return;
    
    
    
    [[AFAppDotNetAPIClient sharedClientNoJson] postPath:URL_TOPIC_ACTIVE
                                             parameters:params
                                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                    NSLog(@"return : %@",operation.responseString);
                                                    //注：此处ruby china 服务器返回的不是 json 格式数据。成功后返回的是字符串“true”
                                                    [self postTopicDataFinish:operation.responseString];
                                                }
                                                failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                                    NSLog(@"error:%@",error);
                                                    [super showHUDComplete:MESSAGE_REQUEST_FAIL];
                                                }];
}

//发布话题完成
- (void)postTopicDataFinish:(id)responseData
{
    [super hideHUD];
    if ([responseData isEqualToString:@"true"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"error when save!");
        [super showHUDComplete:MESSAGE_REQUEST_SERVER_ERROR];
    }
}

#pragma mark - action
- (void)saveTopicAction
{
    if ([self isValidatedContent] == NO) {
        return;
    }
    
    [self postTopicData];
}

#pragma mark - private
- (BOOL)isValidatedContent
{
    BOOL returnBool = NO;
    
    if (self.titleField.text.length == 0) {
        [self.titleField becomeFirstResponder];
        returnBool = NO;
    }else if(self.bodyTextView.text.length == 0){
        [self.bodyTextView becomeFirstResponder];
        returnBool = NO;
    }else if(self.selectedNode == nil){
        returnBool = NO;
    }else{
        returnBool = YES;
    }
    return returnBool;
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    //选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 40, 44)];
        titleLabel.text = @"标题";
        [cell.contentView addSubview:titleLabel];
        
        self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabel.right
                                                                        +2, 4, 250, 40)];
        self.titleField.font = [UIFont systemFontOfSize:12.0f];
        //self.titleField.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:self.titleField];
    }
    
    if (indexPath.row == 1){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 40, 44)];
        titleLabel.text = @"内容";
        [cell.contentView addSubview:titleLabel];
        
        self.bodyTextView = [[UITextView alloc] initWithFrame:CGRectMake(titleLabel.right
                                                                        +2, 4, 250, 80)];
        self.bodyTextView.font = [UIFont systemFontOfSize:12.0f];
        //self.bodyTextView.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:self.bodyTextView];
    }
    
    if (indexPath.row == 2) {
        cell.textLabel.text = @"节点";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.selectedNodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-200, 0, 150, 44)];
        self.selectedNodeLabel.textAlignment = NSTextAlignmentRight;
        //self.selectedNodeLabel.backgroundColor = [UIColor redColor];
        self.selectedNodeLabel.font = [UIFont systemFontOfSize:12.0f];
        [cell.contentView addSubview:self.selectedNodeLabel];
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float returnValue = 44;
    
    if (indexPath.row == 0) {
        returnValue = 44;
    }
    
    if (indexPath.row == 1){
        returnValue = 88;
    }
    
    if (indexPath.row == 2) {
        returnValue = 44;
    }
    return returnValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        NodeSelectViewController *nodeCtrl = [[NodeSelectViewController alloc] init];
        nodeCtrl.nodeSelectDelegate = self;
        [self.navigationController pushViewController:nodeCtrl animated:YES];
    }
}

#pragma mark - NodeSelectDelegate
- (void)getReturnNode:(NodeModel *)node
{
    self.selectedNode = node;
    self.selectedNodeLabel.text = self.selectedNode.name;
}

#pragma mark - dealloc
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
