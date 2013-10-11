//
//  UIUtils.h
//  WXTime
//
//  Created by wei.chen on 12-7-22.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联ios开发培训中心 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject

//获取documents下的文件路径
+ (NSString *)getDocumentsPath:(NSString *)fileName;
// date 格式化为 string
+ (NSString*) stringFromFomate:(NSDate*)date formate:(NSString*)formate;
// string 格式化为 date
+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate;

//格式化这样的日期：Sat Jan 12 11:50:16 +0800 2013 形成新的日期： 08-01 12:30
+ (NSString *)formatString:(NSString *)datestring;

//格式化这样的日期: 2013-10-11T16:28:37.005+08:00 形成新的日期: 08-01 12:30
+ (NSString *)formatRubyChinaString:(NSString *)datestring;

@end
