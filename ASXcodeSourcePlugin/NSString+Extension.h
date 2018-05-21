//
//  NSString+Extension.h
//  HJButtonAddExtension
//
//  Created by 黄静静 on 2017/7/16.
//  Copyright © 2017年 Jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)


/*
 * 返回中间字符串
 * 如果 leftStr 为 nil , 则返回 rightStr 之前的字符串
 */
- (NSString *)stringBetweenLeftStr:(NSString *)leftStr andRightStr:(NSString *)rightStr;

@end
