//
//  InterfaceImageView.m
//  rubychina
//
//  Created by 张 启迪 on 13-10-16.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "InterfaceImageView.h"

@implementation InterfaceImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTapGesture];
    }
    return self;
}

//通过xib创建时不走init，而是走这个awakeFromNib方法
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initTapGesture];
}

- (void)initTapGesture
{
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGesture
{
    if (self.touchBlock) {
        self.touchBlock();
    }
}

@end
