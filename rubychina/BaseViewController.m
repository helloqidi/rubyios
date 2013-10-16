//
//  BaseViewController.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-16.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
	// Do any additional setup after loading the view.
}

#pragma mark - loading
- (void)showLoading:(BOOL)show top:(float)top
{
    if (self.loadingView==nil) {
        self.loadingView=[[UIView alloc] initWithFrame:CGRectMake(0, top, ScreenWidth, 20)];
        
        //风火轮视图
        UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        
        //水平居中
        activityView.left=ScreenWidth/2 - 15;
        
        [self.loadingView addSubview:activityView];
    }
    if (show) {
        if (![self.loadingView superview]) {
            [self.view addSubview:self.loadingView];
        }
    }else{
        [self.loadingView removeFromSuperview];
    }
}
- (void)showLoading:(BOOL)show
{
    //默认垂直居中
    [self showLoading:show top:ScreenHeight/2-40];
}


#pragma mark - HUD
- (void)showHUD:(NSString *)title isDim:(BOOL)isDim
{
    self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (isDim) {
        //黑色背景遮罩
        self.hud.dimBackground=YES;
    }
    if (title.length>0) {
        self.hud.labelText=title;
    }
}
- (void)showHUD:(NSString *)title
{
    //默认不显示黑色背景
    [self showHUD:title isDim:NO];
}

- (void)hideHUD{
    [self.hud hide:YES];
}

- (void)showHUDComplete:(NSString *)title
{
    if (self.hud) {
        [self hideHUD];
    }
    
    self.hud.customView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] ;
    self.hud.mode=MBProgressHUDModeCustomView;
    if (title.length>0) {
        self.hud.labelText=title;
    }
    //2秒后隐藏
    [self.hud hide:YES afterDelay:2];
}

#pragma mark - dealloc
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
