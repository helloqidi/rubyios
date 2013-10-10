//
//  AppDelegate.m
//  rubychina
//
//  Created by 张 启迪 on 13-9-30.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    HomeViewController *homeCtrl = [[HomeViewController alloc] init];
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:homeCtrl];
    self.window.rootViewController = navCtrl;
    
    return YES;
}


@end
