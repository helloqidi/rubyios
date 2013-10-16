//
//  NodeSelectViewController.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-14.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NodeModel.h"

@class NodeSelectViewController;
@protocol NodeSelectDelegate <NSObject>

//获得返回的节点
- (void)getReturnNode:(NodeModel *)node;

@end

@interface NodeSelectViewController : BaseViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, assign)id<NodeSelectDelegate> nodeSelectDelegate;

@end
