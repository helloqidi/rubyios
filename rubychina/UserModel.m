//
//  UserModel.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "UserModel.h"

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

    return self;
}

@end
