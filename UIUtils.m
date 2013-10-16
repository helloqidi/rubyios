//
//  UIUtils.m
//  WXTime
//
//  Created by wei.chen on 12-7-22.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联ios开发培训中心 All rights reserved.
//

#import "UIUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"

@implementation UIUtils

+ (NSString *)getDocumentsPath:(NSString *)fileName {
    
    //两种获取document路径的方式
//    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [paths objectAtIndex:0];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    
    return path;
}

+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	return str;
}

+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    return date;
}

//格式化这样的日期：Sat Jan 12 11:50:16 +0800 2013 形成新的日期： 08-01 12:30
+ (NSString *)formatString:(NSString *)datestring {
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:formate];
    NSString *text = [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
    return text;
}

//格式化这样的日期: 2013-10-11T16:28:37.005+08:00 形成新的日期: 08-01 12:30
+ (NSString *)formatRubyChinaString:(NSString *)datestring
{
    NSString *formate = @"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ";
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:formate];
    NSString *text = [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
    return text;
    
}

+ (NSString *)parseLink:(NSString *)text {
    // regular expresion
    NSString *regex = @"([a-zA-z]+://[^\\s]*)";
    NSArray *matchArray = [text componentsMatchedByRegex:regex];
    
    for (NSString *linkString in matchArray) {
        
        //形成超链接
        // <a href='http://www.baidu.com'>http://www.baidu.com</a>
        NSString *replacement = nil;
        if ([linkString hasPrefix:@"http"]) {
            replacement = [NSString stringWithFormat:@"<a href='%@'>%@</a>", [linkString URLEncodedString], linkString];
        }
        
        if (replacement) {
            text = [text stringByReplacingOccurrencesOfString:linkString withString:replacement];
        }
        
    }
    return text;
}


@end
