//
//  ReplyModel.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-10.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface ReplyModel : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSNumber *bodyHtml;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *updateAt;

@property (nonatomic, strong) UserModel *user;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
