//
//  ViewController.m
//  PPTransparentViewControllerDemo
//
//  Created by richard on 2017/8/10.
//  Copyright © 2017年 richard. All rights reserved.
//

#import "ViewController.h"

#import "DemoViewController.h"

#import "UIView+PPAddition.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel           *selectStringLabel;

@end

@implementation ViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions
- (IBAction)launchClicked:(id)sender
{
    DemoViewController *vc = [[DemoViewController alloc] initWithNibName:NSStringFromClass([DemoViewController class]) bundle:nil];
    
    vc.snapshotImage = self.view.snapshot;
    
    typeof(self) __weak weakSelf = self;
    vc.selectedDoneBlock = ^(NSString *selectedString) {
        typeof(self) __strong strongSelf = weakSelf;

        strongSelf.selectStringLabel.text = selectedString;
    };
    
    [self presentViewController:vc animated:NO completion:nil];
}

@end
