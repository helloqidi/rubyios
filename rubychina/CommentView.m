//
//  CommentView.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-14.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //对UIView使用xib
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:self options:nil] lastObject];
        view.backgroundColor = [UIColor grayColor];
        [self addSubview:view];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
}


@end
