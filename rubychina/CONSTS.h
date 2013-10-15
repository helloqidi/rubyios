//
//  CONSTS.h
//  rubychina
//
//  Created by 张 启迪 on 13-9-30.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#ifndef rubychina_CONSTS_h
#define rubychina_CONSTS_h

///////////////// 社区API接口 start //////////
// API Domain
#define BASE_URL @"http://ruby-china.org/api/"
// 个人特别token
#define MY_TOKEN @"053f71974c3d1a731b6f:580"

//话题列表 / 发布话题
#define URL_TOPIC_ACTIVE @"topics.json"
//话题详情
#define URL_TOPIC_DETAIL @"topics/%@.json"
//发布评论
#define URL_CREATE_REPLY @"topics/%@/replies.json"
//所有节点
#define URL_NODE_ALL @"nodes.json"

///////////////// 社区API接口 end //////////

//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#endif
