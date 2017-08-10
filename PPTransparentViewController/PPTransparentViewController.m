//
//  WWHalfTransparentViewController.m
//  wwlive
//
//  Created by richard on 2017/6/28.
//  Copyright © 2017年 richard. All rights reserved.
//

#import "PPTransparentViewController.h"

#import "NSArray+PPAddition.h"

@interface PPTransparentViewController ()

@property (nonatomic, strong) NSLayoutConstraint                *containerViewMarginBottom;

@property (nonatomic, strong) CALayer                           *backgroundOverlay;
@property (nonatomic, strong) CABasicAnimation                  *backgroundOverlayFadeIn;
@property (nonatomic, strong) CABasicAnimation                  *backgroundOverlayFadeOut;

@property (nonatomic, assign) CGPoint                           dragStartPoint;

@end

@implementation PPTransparentViewController

#pragma mark - Init
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self __defaultSetUp];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self __defaultSetUp];
    }
    
    return self;
}

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setupUI
    
    [self setupGesture];
    
    [self __setUpForAnimate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self __animateInWithMaskFadeIn:YES];
    
    [self.containerView addGestureRecognizer:self.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private
- (void)__defaultSetUp
{
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDragDownContainer:)];
    
    self.isDismissing = NO;
}

- (void)__setUpForAnimate
{
    NSLayoutConstraint *marginBottom = self.containerViewMarginBottom;
    
    [self.containerView layoutIfNeeded];
    
    marginBottom.constant = -self.containerView.bounds.size.height;
    
    [self.view.layer insertSublayer:self.backgroundOverlay atIndex:0];
}

- (void)__animateInWithMaskFadeIn:(BOOL)needsFadeIn
{
    self.containerViewMarginBottom.constant = 0;
    [self.view setNeedsLayout];
    
    [UIView animateWithDuration:0.24 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    if (needsFadeIn) {
        [self.backgroundOverlay addAnimation:self.backgroundOverlayFadeIn forKey:self.backgroundOverlayFadeIn.keyPath];
    }
}

- (void)__animateOutWithCompletion:(void (^)(BOOL finished))completion
{
    [self.containerView layoutIfNeeded];
    
    self.containerViewMarginBottom.constant = -self.containerView.bounds.size.height;
    [self.view setNeedsLayout];
    
    [UIView animateWithDuration:0.24
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:completion];
    
    [self.backgroundOverlay addAnimation:self.backgroundOverlayFadeOut forKey:self.backgroundOverlayFadeIn.keyPath];
}

#pragma mark - Getter
- (UITapGestureRecognizer *)tapGesture
{
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWasRecognized:)];
        [_tapGesture setNumberOfTapsRequired:1];
    }
    
    return _tapGesture;
}

- (NSLayoutConstraint *)containerViewMarginBottom
{
    if (_containerViewMarginBottom == nil) {
        _containerViewMarginBottom = [self.view.constraints pp_filter:^BOOL(NSLayoutConstraint *constraint) {
            return constraint.secondItem == self.containerView && constraint.secondAttribute == NSLayoutAttributeBottom;
        }].firstObject;
    }
    
    return _containerViewMarginBottom;
}

- (CALayer *)backgroundOverlay
{
    if (_backgroundOverlay == nil) {
        _backgroundOverlay = [[CALayer alloc] init];
        _backgroundOverlay.frame = [UIScreen mainScreen].bounds;
        _backgroundOverlay.opacity = 0;
        _backgroundOverlay.backgroundColor = [UIColor blackColor].CGColor;
    }
    
    return _backgroundOverlay;
}

- (CABasicAnimation *)backgroundOverlayFadeOut
{
    if (_backgroundOverlayFadeOut == nil) {
        _backgroundOverlayFadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _backgroundOverlayFadeOut.toValue = @(0);
        _backgroundOverlayFadeOut.duration = 0.2;
        _backgroundOverlayFadeOut.fillMode = kCAFillModeForwards;
        _backgroundOverlayFadeOut.removedOnCompletion = NO;
    }
    
    return _backgroundOverlayFadeOut;
}

- (CABasicAnimation *)backgroundOverlayFadeIn
{
    if (_backgroundOverlayFadeIn == nil) {
        _backgroundOverlayFadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _backgroundOverlayFadeIn.toValue = @(0.4);
        _backgroundOverlayFadeIn.duration = 0.2;
        _backgroundOverlayFadeIn.fillMode = kCAFillModeForwards;
        _backgroundOverlayFadeIn.removedOnCompletion = NO;
    }
    
    return _backgroundOverlayFadeIn;
}

#pragma mark - Public Method
- (void)setupGesture
{
    [self.view addGestureRecognizer:self.tapGesture];
}

#pragma mark - Actions
- (void)handleDragDownContainer:(UIGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    
    CGPoint dragStartPoint = self.dragStartPoint;
    CGPoint dragEndPoint = [sender locationInView:self.view];
    
    CGFloat dragDistance = dragEndPoint.y - dragStartPoint.y;
    
    CGFloat containerHeight = self.containerView.bounds.size.height;
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            self.dragStartPoint = [sender locationInView:self.view];
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            if (dragDistance > 0 && dragDistance <= containerHeight / 2) {
                [self __animateInWithMaskFadeIn:NO];
            }
            
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            if (dragDistance > containerHeight / 2) {
                [self dismissViewController];
            } else if (dragDistance > 0) {
                self.containerViewMarginBottom.constant = -dragDistance;
            }
            
            break;
        }
            
        default:
            break;
    }
}

- (void)dismissViewController
{
    if (self.isDismissing) {
        return;
    }
    
    self.isDismissing = YES;
    [self __animateOutWithCompletion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)tapWasRecognized:(UITapGestureRecognizer *)recognizer
{
    [self dismissViewController];
}

@end
