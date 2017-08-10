//
//  NSArray+WWAddition.m
//  wwlive
//
//  Created by richard on 2017/6/28.
//  Copyright © 2017年 richard. All rights reserved.
//

#import "NSArray+PPAddition.h"

@implementation NSArray (PPAddition)

- (NSArray *)pp_filter:(BOOL (^)(id object))block
{
    NSParameterAssert(block != nil);
    
    NSMutableArray __block *result = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj != nil && block(obj)) {
            [result addObject:obj];
        }
    }];
    
    return result;
}

@end
