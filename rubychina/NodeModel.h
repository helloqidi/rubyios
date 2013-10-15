//
//  NodeModel.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-15.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodeModel : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *topicsCount;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSNumber *sort;

@property (nonatomic, strong) NSNumber *sectionId;
@property (nonatomic, strong) NSString *sectionName;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
