//
//  UIView+WWAddition.m
//  wwlive
//
//  Created by richard on 2017/5/25.
//  Copyright © 2017年 richard. All rights reserved.
//

#import "UIView+PPAddition.h"

@implementation UIView (PPAddition)

- (UIImage *)snapshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
