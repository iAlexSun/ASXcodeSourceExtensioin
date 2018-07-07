//
//  ASAutoLayoutViewCode.m
//  ASXcodeSourceExtensioin
//
//  Created by Sun Wen on 2018/5/17.
//  Copyright © 2018年 Sun Wen. All rights reserved.
//

#import "ASAutoLayoutViewCode.h"
#import "NSString+Extension.h"
#import "ASConst.h"

@implementation ASAutoLayoutViewCode

+ (void)addAutoLayoutViewCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation {
    for (XCSourceTextRange *rang in invocation.buffer.selections) {
        NSInteger startLine = rang.start.line;
        NSInteger endLine = rang.end.line;
        NSInteger lineCount = invocation.buffer.lines.count;

        NSMutableArray *nameArr = [NSMutableArray array];
        NSMutableArray *containtsArr = [NSMutableArray array];
        NSMutableArray *subviewsArr = [NSMutableArray array];
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
            
            
            //判断NSMutableArray<NSString *> *testArray 这样的情况来处理
            if ([string containsString:@"NSMutableArray<"]) {
                classNameStr = [string stringBetweenLeftStr:@")" andRightStr:@"*>"];
                classNameStr = [classNameStr stringByAppendingString:@"*>"];
                propertyNameStr = [string stringBetweenLeftStr:@"*>*" andRightStr:@";"];
            }else if ([string containsString:@")"]) {
                classNameStr = [string stringBetweenLeftStr:@")" andRightStr:@"*"];
            }else{
                classNameStr = [string stringBetweenLeftStr:nil andRightStr:@"*"];
            }
            
            NSArray *formatArr = [self stringForClassName:classNameStr andPropertyName:propertyNameStr];
            [nameArr addObject:formatArr];

            // 获取布局
            NSArray *conArr = [self constraintsForClassName:classNameStr PropertyName:propertyNameStr];
            [containtsArr addObject:conArr];

            // 获取添加subView
            NSArray *subViewArr = [self addSubViewForClassName:classNameStr PropertyName:propertyNameStr];
            [subviewsArr addObject:subViewArr];
        }

        //输出到文件
        for (NSInteger i = 0; i < lineCount; i ++) {
            NSString *lineStr = invocation.buffer.lines[i];
            if ([lineStr containsString:@"#pragma mark - Get"] || [lineStr containsString:@"#pragma mark -Get"] || [lineStr containsString:@"#pragma mark- Get"] || [lineStr containsString:@"#pragma mark-Get"]) {
                for (NSInteger j = i + 1; j < nameArr.count + i + 1; j ++) {
                    NSArray *formatArr = [nameArr objectAtIndex:nameArr.count - j - 1  + (i + 1 )];
                    for (int z = 0; z <formatArr.count ; z ++) {
                        [invocation.buffer.lines insertObject:formatArr[z] atIndex:i + 1  + z];
                    }
                }
            }

            if ([lineStr containsString:@"#pragma mark - Masonry"]|| [lineStr containsString:@"#pragma mark -Masonry"] ||[lineStr containsString:@"#pragma mark- Masonry"] || [lineStr containsString:@"#pragma mark-Masonry"]) {
                for (NSInteger j = i + 1; j < containtsArr.count + i + 1; j ++) {
                    NSArray *cArr = [containtsArr objectAtIndex:containtsArr.count - j - 1  + (i + 1 )];
                    for (int z = 0; z <cArr.count ; z ++) {
                        [invocation.buffer.lines insertObject:cArr[z] atIndex:i + 1 + z];
                    }
                }
            }
            if ([lineStr containsString:@"#pragma mark - Add"]||[lineStr containsString:@"#pragma mark -Add"]||[lineStr containsString:@"#pragma mark- Add"]||[lineStr containsString:@"#pragma mark-Add"]) {
                for (NSInteger j = i + 1; j < subviewsArr.count + i + 1; j ++) {
                    NSArray *subArr = [subviewsArr objectAtIndex:subviewsArr.count - j - 1  + (i + 1 )];
                    for (int z = 0; z <subArr.count ; z ++) {
                        [invocation.buffer.lines insertObject:subArr[z] atIndex:i + 1 + z];
                    }
                }
            }
        }
    }
}

+ (NSArray *)stringForClassName:(NSString *)className andPropertyName:(NSString *)propertyName{
    NSString *str = @"";
    if ([className containsString:@"TableView"]){
        str = [NSString stringWithFormat:TableFormat,className,propertyName,propertyName,propertyName,className,propertyName];
    }else if ([className containsString:@"CollectionView"]){
        str = [NSString stringWithFormat:CollectionFormat,className,propertyName,propertyName,propertyName,className,propertyName];
    }else if ([className containsString:@"RACCommand"]){
        str = [NSString stringWithFormat:Command,propertyName,propertyName,propertyName,propertyName];
    }else{
        str = [NSString stringWithFormat:CommonFormat,className,propertyName,propertyName,propertyName,className,propertyName];
    }
    NSArray *formaterArr = [[str componentsSeparatedByString:@"\n"] arrayByAddingObject:@"\n"];

    return formaterArr;
}
 
//这里之后需要修改逻辑,去判断是否自定义的view还有其他类型的概念
+ (NSArray *)constraintsForClassName:(NSString *)className PropertyName:(NSString *)propertyName {
    if ([className containsString:@"Button"] || [className containsString:@"View"] ||[className containsString:@"Label"] || [className containsString:@"UIImageView"] || [className containsString:@"TextField"] || [className containsString:@"TextView"]) {

        NSString *str = [NSString stringWithFormat:PHEMasonryFormat,propertyName];
        NSArray *conArr = [[str componentsSeparatedByString:@"\n"] arrayByAddingObject:@"\n"];
        return conArr;
    }
    return [NSMutableArray array];
}

+ (NSArray *)addSubViewForClassName:(NSString *)className PropertyName:(NSString *)propertyName {
     if ([className containsString:@"Button"] || [className containsString:@"View"] ||[className containsString:@"Label"] || [className containsString:@"UIImageView"] || [className containsString:@"TextField"] || [className containsString:@"TextView"]) {

         NSString *str = [NSString stringWithFormat:AddsubviewFormat,propertyName];
         NSArray *conArr = [[str componentsSeparatedByString:@""] arrayByAddingObject:@""];
         return conArr;
     }
    return [NSMutableArray array];
}

@end
