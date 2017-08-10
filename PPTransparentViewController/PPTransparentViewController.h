//
//  WWHalfTransparentViewController.h
//  wwlive
//
//  Created by richard on 2017/6/28.
//  Copyright © 2017年 richard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPTransparentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView                     *containerView;

@property (nonatomic, strong) UITapGestureRecognizer            *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer            *panGestureRecognizer;

@property (nonatomic, assign) BOOL                              isDismissing;

- (void)setupGesture;
- (void)dismissViewController;

@end
