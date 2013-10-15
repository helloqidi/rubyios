//
//  NodeSelectViewController.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-14.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "NodeSelectViewController.h"
#import "NodeModel.h"

@interface NodeSelectViewController ()

@property (nonatomic, strong) NSMutableDictionary *nodeModelsDic;

//用于一级下拉
@property (nonatomic, strong) NSMutableArray *sectionNames;
//用于二级下拉
@property (nonatomic, strong) NSMutableArray *nodeNames;

@end

@implementation NodeSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title =@"选择节点";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化变量
    self.nodeModelsDic = [NSMutableDictionary dictionary];
    self.sectionNames = [NSMutableArray array];
    self.nodeNames = [NSMutableArray array];
    
    
    [self initBarButtonItems];
    
    [self requestNodeData];
}

- (void)initBarButtonItems
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}


#pragma mark - data
- (void)requestNodeData
{
    [[AFAppDotNetAPIClient sharedClient] getPath:URL_NODE_ALL
                                      parameters:nil
                                         success:^(AFHTTPRequestOperation *operation, id JSON) {
                                             NSArray *jsonArray = (NSArray *) JSON;
                                             [self requestNodeDataFinish:jsonArray];
                                         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                             NSLog(@"error:%@",error);
                                         }];
}


- (void)requestNodeDataFinish:(NSArray *)jsonArray
{
    for (NSDictionary *nodeDic in jsonArray) {
        //获得section信息
        NSString *sectionName = [nodeDic objectForKey:@"section_name"];
        [self.sectionNames addObject:sectionName];
        
        //获得所有node信息
        NodeModel *node = [[NodeModel alloc] initWithAttributes:nodeDic];
        NSMutableArray *nodeModelArray = [self.nodeModelsDic objectForKey:node.sectionName];
        if (nodeModelArray == nil) {
            nodeModelArray = [NSMutableArray array];
            [self.nodeModelsDic setValue:nodeModelArray forKey:node.sectionName];
        }
        [nodeModelArray addObject:node];
    }
    //去重复
    [self uniqueNSMutableArray:self.sectionNames];
    
    //默认选择第一个section
    NSString *selectedSection = [self.sectionNames objectAtIndex:0];
    self.nodeNames = [self.nodeModelsDic objectForKey:selectedSection];

    [self.pickerView reloadAllComponents];
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.sectionNames.count;
    }else{
        return self.nodeNames.count;
    }
}


#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.sectionNames objectAtIndex:row];
    }else{
        NodeModel *node = [self.nodeNames objectAtIndex:row];
        return node.name;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        NSString *selectedSection = [self.sectionNames objectAtIndex:row];
        self.nodeNames = [self.nodeModelsDic objectForKey:selectedSection];
        //默认选择第一个
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];     // 选中上层时, 相应的下层的数据会变动
    }
}

#pragma mark - action
- (void)saveAction
{
    //当前选中的节点
    NSUInteger selectedRow = [self.pickerView selectedRowInComponent:1];
    NodeModel *selectedNode = [self.nodeNames objectAtIndex:selectedRow];
    
    [self.nodeSelectDelegate getReturnNode:selectedNode];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private
- (void)uniqueNSMutableArray:(NSMutableArray *)mutableArray
{
    NSArray *copy = [mutableArray copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([mutableArray indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [mutableArray removeObjectAtIndex:index];
        }
        index--;
    }
}


#pragma mark - dealloc
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
