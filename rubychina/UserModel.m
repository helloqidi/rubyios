//
//  UserModel.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "UserModel.h"
#import "TopicModel.h"

@implementation UserModel

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _id = [attributes valueForKeyPath:@"id"];
    _avatarUrl = [attributes valueForKey:@"avatar_url"];
    _login = [attributes valueForKey:@"login"];
    _email = [attributes valueForKey:@"email"];
    
    //回复
    NSMutableArray *topicModels = [NSMutableArray array];
    NSArray *topicArray = [attributes valueForKey:@"topics"];
    if (topicArray.count > 0) {
        for (NSDictionary *dic in topicArray) {
            TopicModel *topicModel = [[TopicModel alloc] initWithAttributes:dic];
            [topicModels addObject:topicModel];
        }
    }
    _topics = topicModels;
    
    return self;
}

@end
