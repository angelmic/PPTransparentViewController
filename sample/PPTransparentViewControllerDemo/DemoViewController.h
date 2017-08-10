//
//  DemoViewController.h
//  PPTransparentViewControllerDemo
//
//  Created by richard on 2017/8/10.
//  Copyright © 2017年 richard. All rights reserved.
//

#import <PPTransparentViewController/PPTransparentViewController.h>

@interface DemoViewController : PPTransparentViewController

@property (nonatomic, copy) void (^selectedDoneBlock)(NSString *selectedString);

@property (nonatomic, copy) UIImage  *snapshotImage;

@end
