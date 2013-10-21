//
//  ReaderViewController.h
//  rubychina
//
//  Created by 张 启迪 on 13-10-21.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ReaderViewController : UIViewController <ZBarReaderDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *resultImage;
@property (strong, nonatomic) IBOutlet UITextView *resultText;

- (IBAction)scanButtonTapped:(id)sender;

@end
