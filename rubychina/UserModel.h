//
//  UserModel.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

//id
@property (nonatomic, strong) NSNumber *id;
//头像地址
@property (nonatomic, strong) NSString *avatarUrl;
//昵称
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *email;

//话题
@property (nonatomic, strong) NSArray *topics;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
