//
//  DemoViewController.m
//  PPTransparentViewControllerDemo
//
//  Created by richard on 2017/8/10.
//  Copyright © 2017年 richard. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@property (weak, nonatomic) IBOutlet UIView         *backgroundContainer;

@end

@implementation DemoViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self __setupUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - OverWrite
- (void)setupGesture
{
    [super setupGesture];
    [self.backgroundContainer addGestureRecognizer:self.tapGesture];
}

#pragma mark - Private
- (void)__setupUI
{
    if (self.snapshotImage) {
        UIImageView *bkview = [[UIImageView alloc] initWithImage:self.snapshotImage];
        
        bkview.frame = self.backgroundContainer.bounds;
        
        [self.backgroundContainer addSubview:bkview];
    }
}

#pragma mark - Actions
- (IBAction)String001Clicked:(id)sender
{
    if (self.selectedDoneBlock) {
        self.selectedDoneBlock(@"Demo String 001");
    }
    
    [self dismissViewController];
}

- (IBAction)String002Clicked:(id)sender
{
    if (self.selectedDoneBlock) {
        self.selectedDoneBlock(@"Demo String 002");
    }
    
    [self dismissViewController];
}

@end
