//
//  ReplyModel.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "ReplyModel.h"

@implementation ReplyModel


- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _id = [attributes valueForKeyPath:@"id"];
    _body = [attributes valueForKey:@"body"];
    _bodyHtml = [attributes valueForKey:@"bodyHtml"];
    _createdAt = [attributes valueForKey:@"created_at"];
    _updateAt = [attributes valueForKey:@"updated_at"];
    
    //用户信息
    _user = [[UserModel alloc] initWithAttributes:[attributes valueForKey:@"user"]];
    
    return self;
}

@end

