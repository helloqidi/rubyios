//
//  BaseViewController.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-16.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController

//简单的“加载中”视图
@property(nonatomic,retain)UIView *loadingView;

@property(nonatomic,retain)MBProgressHUD *hud;


//简单的网络加载提示
- (void)showLoading:(BOOL)show top:(float)top;
- (void)showLoading:(BOOL)show;

//HUD控件
- (void)showHUD:(NSString *)title isDim:(BOOL)isDim;
- (void)showHUD:(NSString *)title;
//隐藏HUD
- (void)hideHUD;
//HUD提示完成
- (void)showHUDComplete:(NSString *)title;

@end
