//
//  NodeModel.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-15.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "NodeModel.h"

@implementation NodeModel

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _id = [attributes valueForKeyPath:@"id"];
    _name = [attributes valueForKeyPath:@"name"];
    _topicsCount = [attributes valueForKey:@"topics_count"];
    _summary = [attributes valueForKey:@"summary"];
    _sort = [attributes valueForKey:@"sort"];
    _sectionId = [attributes valueForKey:@"section_id"];
    _sectionName = [attributes valueForKey:@"section_name"];
    
    return self;
}

@end
