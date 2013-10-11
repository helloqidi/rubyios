//
//  TopicModel.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface TopicModel : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *lastReplyUserId;
@property (nonatomic, strong) NSString *lastReplyUserLogin;
//节点id
@property (nonatomic, strong) NSNumber *nodeId;
//节点名称
@property (nonatomic, strong) NSString *nodeName;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *updateAt;
@property (nonatomic, strong) NSString *repliedAt;
@property (nonatomic, strong) NSNumber *repliedCount;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *bodyHtml;
@property (nonatomic, strong) NSNumber *hits;

@property (nonatomic, strong) UserModel *user;
@property (nonatomic, strong) NSArray *replies;


- (id)initWithAttributes:(NSDictionary *)attributes;

@end
