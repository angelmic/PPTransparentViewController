//
//  NSArray+WWAddition.h
//  wwlive
//
//  Created by richard on 2017/6/28.
//  Copyright © 2017年 richard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (PPAddition)


/**
 簡易過濾方法

 @param block 過濾元素的規則
 @return      返回過濾結果
 */
- (NSArray *)pp_filter:(BOOL (^)(id object))block;

@end
