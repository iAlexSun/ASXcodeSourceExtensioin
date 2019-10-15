//
//  ASAutoGenerateCode.m
//  ASXcodeSourceExtensioin
//
//  Created by Sun Wen on 2018/5/17.
//  Copyright © 2018年 Sun Wen. All rights reserved.
//

#import "ASAutoGenerateCode.h"
#import "NSString+Extension.h"

@interface ASAutoGenerateCode()

@property(nonatomic,strong)NSMutableDictionary *propertyDics;

@end

@implementation ASAutoGenerateCode

- (void)autoGenerateCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation {
    for (XCSourceTextRange *rang in invocation.buffer.selections) {
        [self initWithFormaterArray:rang invocation:invocation];
        [self addBufferInsertInvocation:invocation];
    }
}

- (void)initWithFormaterArray:(XCSourceTextRange *)rang invocation:(XCSourceEditorCommandInvocation *)invocation {
    [self.propertyDics removeAllObjects];
    
    NSMutableDictionary *dataDic = [self getRulesData];
    if (!dataDic) return;
    
    NSInteger startLine = rang.start.line;
    NSInteger endLine = rang.end.line;
    
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
        
        for (NSDictionary *dic in dataDic.allValues) {
           NSMutableDictionary *rules = dic[@"rule"];
           NSString *dicKey = dic[@"path"];
           NSArray *ruleArray = [self ruleForClassName:classNameStr andPropertyName:propertyNameStr rules:rules];
    
           //通用规则
           NSMutableArray *propertyArray = [NSMutableArray arrayWithArray:self.propertyDics[dicKey]];
           if (ruleArray.count>0 && propertyArray) {
               [propertyArray addObject:ruleArray];
               self.propertyDics[dicKey] = [propertyArray copy];
           }
        }
    }
}
//进行判断进行替换
- (void)addBufferInsertInvocation:(XCSourceEditorCommandInvocation *)invocation {
    NSArray *bufferLines = invocation.buffer.lines;
    for (NSInteger i = 0; i < [bufferLines count]; i ++) {
        NSString *lineStr = invocation.buffer.lines[i];
        //按照规则通用情况
        NSArray *propertyValue = [self checkCurrentString:lineStr isContainsWithPropertyDics:self.propertyDics];
        if (lineStr && propertyValue.count > 0) {
            [self addBufferWithCurrentLineIndex:i formaterArray:[propertyValue copy] invocation:invocation lineStr:lineStr];
        }
    }
}

- (void)addBufferWithCurrentLineIndex:(NSInteger)currentLineIndex formaterArray:(NSMutableArray *)formaterArray  invocation:(XCSourceEditorCommandInvocation *)invocation lineStr:(NSString *)lineStr {
    //这里的循环主要就是开始 在检测到的下一行开始轮询
    for (NSInteger i = currentLineIndex + 1; i < formaterArray.count + currentLineIndex + 1; i ++) {
        NSArray *formatArr = [formaterArray objectAtIndex:formaterArray.count - i - 1  + (currentLineIndex + 1 )];
        for (int j = 0; j <formatArr.count ; j ++) {
            NSString *lineSpce = [lineStr componentsSeparatedByString:@"//"][0];
            NSString *insertLine = [NSString stringWithFormat:@"%@%@",lineSpce,formatArr[j]];
            [invocation.buffer.lines insertObject:insertLine atIndex:currentLineIndex + 1  + j];
        }
    }
}
- (NSArray *)checkCurrentString:(NSString *)lineString isContainsWithPropertyDics:(NSDictionary *)isContainsWithPropertyDics {
    NSString *str = [lineString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *finalStr = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if ([isContainsWithPropertyDics objectForKey:finalStr]){
        return [isContainsWithPropertyDics objectForKey:finalStr];
    }
    return nil;
}
//根据规则匹配,如包含DisplayNode->生成特定字符串->将propertyName,className替换为
- (NSArray *)ruleForClassName:(NSString *)className andPropertyName:(NSString *)propertyName rules:(NSMutableDictionary *)rules {
    NSArray *formaterArr = [NSArray array];
    for (NSDictionary *rule in rules) {
        NSString *ruleKey = rule.allKeys[0];
        NSString *ruleValue = rule.allValues[0];
        if ([className containsString:ruleKey] || [[className lowercaseString] isEqualToString:ruleKey] || [[ruleKey lowercaseString] isEqualToString:@"all"]){
             NSString *str = [NSString stringWithFormat:@"%@",ruleValue];
             str = [ruleValue stringByReplacingOccurrencesOfString:@"propertyName" withString:propertyName];
             str = [str stringByReplacingOccurrencesOfString:@"className" withString:className];
             formaterArr = [[str componentsSeparatedByString:@"\n"] arrayByAddingObject:@""];
        }
    }
    return formaterArr;
}

- (NSMutableDictionary *)getRulesData {
    NSURL *path = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.ASXcodeSourcePlugin"];
    NSURL *filePath = [path URLByAppendingPathComponent:@"rules.plist"];
    NSMutableDictionary *rulesDics = [NSMutableDictionary dictionaryWithContentsOfURL:filePath];
    if (filePath && rulesDics) {
        return rulesDics;
    }else{
        //如果有则读取本地plist
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"rules" ofType:@"plist"];
        return [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    }
    return [NSMutableDictionary dictionary];
}

- (NSMutableDictionary *)propertyDics{
    if (_propertyDics == nil) {
        _propertyDics = [NSMutableDictionary dictionary];
    }
    return _propertyDics;
}

+ (ASAutoGenerateCode *)sharedInstane{
    static dispatch_once_t predicate;
    static ASAutoGenerateCode * sharedInstane;
    dispatch_once(&predicate, ^{
        sharedInstane = [[ASAutoGenerateCode alloc] init];
    });
    return sharedInstane;
}
@end
