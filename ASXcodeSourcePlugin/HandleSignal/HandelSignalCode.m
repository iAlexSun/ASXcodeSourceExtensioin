//
//  ASAutoLayoutViewCode.m
//  ASXcodeSourceExtensioin
//
//  Created by Sun Wen on 2018/5/17.
//  Copyright © 2018年 Sun Wen. All rights reserved.
//

#import "HandelSignalCode.h"
#import "NSString+Extension.h"
#import "ASConst.h"

@implementation HandelSignalCode

+ (void)handelSignalCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation {
    for (XCSourceTextRange *rang in invocation.buffer.selections) {
        NSInteger startLine = rang.start.line;
        NSInteger endLine = rang.end.line;
        NSInteger lineCount = invocation.buffer.lines.count;

        NSMutableArray *signalsArr = [NSMutableArray array];
        
        for (NSInteger i = startLine; i <= endLine; i++) {
            NSString *string = invocation.buffer.lines[i];

            if ([string isEqualToString:@"\n"] || ![string containsString:@";"]) {
                continue;
            }
            // 去掉空格
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            // 获取类名
            NSString *classNameStr = nil;
            // 获取属性名或者变量名
            NSString *propertyNameStr = [string stringBetweenLeftStr:@"*" andRightStr:@";"];
            
            if ([string containsString:@")"]) {
                classNameStr = [string stringBetweenLeftStr:@")" andRightStr:@"*"];
            }else{
                classNameStr = [string stringBetweenLeftStr:nil andRightStr:@"*"];
            }
            
            NSArray *formatArr = [self stringForClassName:classNameStr andPropertyName:propertyNameStr];
            [signalsArr addObject:formatArr];

        }
        //输出到文件
        for (NSInteger i = 0; i < lineCount; i ++) {
            NSString *lineStr = invocation.buffer.lines[i];
            if ([lineStr containsString:@"#pragma mark - HandleSignal"]) {
                for (NSInteger j = i + 1; j < signalsArr.count + i + 1; j ++) {
                    NSArray *cArr = [signalsArr objectAtIndex:signalsArr.count - j - 1  + (i + 1 )];
                    for (int z = 0; z <cArr.count ; z ++) {
                        [invocation.buffer.lines insertObject:cArr[z] atIndex:i + 1 + z];
                    }
                }
            }
        }
        
        
    }
}

+ (NSArray *)stringForClassName:(NSString *)className andPropertyName:(NSString *)propertyName{
    NSString *str = @"";
    if ([className containsString:@"RACCommand"]){
        str = [NSString stringWithFormat:CommandSignal,propertyName];
    }
    NSArray *formaterArr = [[str componentsSeparatedByString:@"\n"] arrayByAddingObject:@"\n"];

    return formaterArr;
}
 

@end
