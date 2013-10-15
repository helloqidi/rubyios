//
//  TopicModel.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "TopicModel.h"
#import "ReplyModel.h"

@implementation TopicModel

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _id = [attributes valueForKeyPath:@"id"];
    _title = [attributes valueForKeyPath:@"title"];
    _lastReplyUserId = [attributes valueForKey:@"last_reply_user_id"];
    _lastReplyUserLogin = [attributes valueForKey:@"last_reply_user_login"];
    _nodeId = [attributes valueForKey:@"node_id"];
    _nodeName = [attributes valueForKey:@"node_name"];
    _createdAt = [attributes valueForKey:@"created_at"];
    _updateAt = [attributes valueForKey:@"updated_at"];
    _repliedAt = [attributes valueForKey:@"replied_at"];
    _repliedCount = [attributes valueForKey:@"replies_count"];
    _body = [attributes valueForKey:@"body"];
    _bodyHtml = [attributes valueForKey:@"bodyHtml"];
    _hits = [attributes valueForKey:@"hits"];

    //用户信息
    _user = [[UserModel alloc] initWithAttributes:[attributes valueForKey:@"user"]];
    
    //回复
    NSMutableArray *replyModels = [NSMutableArray array];
    NSArray *replyArray = [attributes valueForKey:@"replies"];
    if (replyArray.count > 0) {
        for (NSDictionary *dic in replyArray) {
            ReplyModel *replyModel = [[ReplyModel alloc] initWithAttributes:dic];
            [replyModels addObject:replyModel];
        }
    }
    _replies = replyModels;
    
    return self;
}

@end
