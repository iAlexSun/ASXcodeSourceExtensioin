//
//  NSString+Extension.m
//  HJButtonAddExtension
//
//  Created by 黄静静 on 2017/7/16.
//  Copyright © 2017年 Jing. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)stringBetweenLeftStr:(NSString *)leftStr andRightStr:(NSString *)rightStr {
    NSString *str = @"";
    NSArray *arr = [NSArray array];
    if (!leftStr) {
        arr = [self componentsSeparatedByString:rightStr];
        if (arr.count > 0) {
            str = arr.firstObject;
        }
    } else {
        arr = [self componentsSeparatedByString:leftStr];
        if (arr.count > 1) {
            NSArray * subArr = [arr[1] componentsSeparatedByString:rightStr];
            if (subArr.count > 0) {
                str = subArr.firstObject;
                if ([str containsString:@"_"]) {
                    str = [str stringByReplacingOccurrencesOfString:@"_" withString:@""];
                }
            }
        }
    }

    return str;
}

@end
