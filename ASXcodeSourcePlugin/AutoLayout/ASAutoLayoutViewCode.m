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

@interface ASAutoLayoutViewCode()

@property(nonatomic,copy)NSMutableArray *lazyArray;

@property(nonatomic,copy)NSMutableArray *containtsArray;

@property(nonatomic,copy)NSMutableArray *subviewsArray;
//当前字符流的行数
@property(nonatomic,assign)NSInteger lineCount;

@end

@implementation ASAutoLayoutViewCode

- (void)addAutoLayoutViewCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation {
    for (XCSourceTextRange *rang in invocation.buffer.selections) {
        NSInteger startLine = rang.start.line;
        NSInteger endLine = rang.end.line;
        
        self.lineCount = invocation.buffer.lines.count;
        
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
            
            //懒加载
            [self.lazyArray addObject:[self stringForClassName:classNameStr andPropertyName:propertyNameStr]];
            // 获取布局
            [self.containtsArray addObject:[self constraintsForClassName:classNameStr PropertyName:propertyNameStr]];
            // 获取添加subView
            [self.subviewsArray addObject:[self addSubViewForClassName:classNameStr PropertyName:propertyNameStr]];
        }

        //输出到文件
        for (NSInteger i = 0; i < self.lineCount; i ++) {
            NSString *lineStr = invocation.buffer.lines[i];
            if ([self checkCurrentString:lineStr isContainsString:kGetterFormater]) {
                [self addBufferWithCurrentLineIndex:i formaterArray:self.lazyArray invocation:invocation];
            }else if ([self checkCurrentString:lineStr isContainsString:kMasonryFormater]) {
                [self addBufferWithCurrentLineIndex:i formaterArray:self.containtsArray invocation:invocation];
            }else if ([self checkCurrentString:lineStr isContainsString:kAddSubviewFormater]){
                [self addBufferWithCurrentLineIndex:i formaterArray:self.subviewsArray invocation:invocation];
            }
        }
        
    }
}


-(void)addBufferWithCurrentLineIndex:(NSInteger)currentLineIndex formaterArray:(NSMutableArray *)formaterArray  invocation:(XCSourceEditorCommandInvocation *)invocation {
       //这里的数字是不同的,需要对自动化生成的行数来决定的
//        self.lineCount = formaterArray.count *10 + self.lineCount;
        //这里的循环主要就是开始 在检测到的下一行开始轮询
        for (NSInteger i = currentLineIndex + 1; i < formaterArray.count + currentLineIndex + 1; i ++) {
            NSArray *formatArr = [formaterArray objectAtIndex:formaterArray.count - i - 1  + (currentLineIndex + 1 )];
            for (int z = 0; z <formatArr.count ; z ++) {
                [invocation.buffer.lines insertObject:formatArr[z] atIndex:i + 1  + z];
            }
        }
}
-(BOOL)checkCurrentString:(NSString *)lineString isContainsString:(NSString *)isContainsString{
    if ([lineString containsString:isContainsString]){
        NSLog(@"---YES");
        return YES;
    }
    NSLog(@"---NO");
    return NO;
}

- (NSArray *)stringForClassName:(NSString *)className andPropertyName:(NSString *)propertyName{
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
    NSArray *formaterArr = [[str componentsSeparatedByString:@"\n"] arrayByAddingObject:@""];

    return formaterArr;
}
 
//这里之后需要修改逻辑,去判断是否自定义的view还有其他类型的概念
- (NSArray *)constraintsForClassName:(NSString *)className PropertyName:(NSString *)propertyName {
    if ([className containsString:@"Button"] || [className containsString:@"View"] ||[className containsString:@"Label"] || [className containsString:@"UIImageView"] || [className containsString:@"TextField"] || [className containsString:@"TextView"]) {

        NSString *str = [NSString stringWithFormat:kASMasonryFormater,propertyName];
        NSArray *conArr = [[str componentsSeparatedByString:@"\n"] arrayByAddingObject:@""];
        return conArr;
    }
    return [NSMutableArray array];
}

- (NSArray *)addSubViewForClassName:(NSString *)className PropertyName:(NSString *)propertyName {
     if ([className containsString:@"Button"] || [className containsString:@"View"] ||[className containsString:@"Label"] || [className containsString:@"UIImageView"] || [className containsString:@"TextField"] || [className containsString:@"TextView"]) {

         NSString *str = [NSString stringWithFormat:AddsubviewFormat,propertyName];
         NSArray *conArr = [[str componentsSeparatedByString:@""] arrayByAddingObject:@""];
         return conArr;
     }
   
    
    return [NSMutableArray array];
}


#pragma mark - Get
-(NSMutableArray *)lazyArray{
    if (_lazyArray == nil) {
        _lazyArray = [[NSMutableArray alloc] init];
    }
    return _lazyArray;
}
-(NSMutableArray *)containtsArray{
    if (_containtsArray == nil) {
        _containtsArray = [[NSMutableArray alloc] init];
    }
    return _containtsArray;
}
-(NSMutableArray *)subviewsArray{
    if (_subviewsArray == nil) {
        _subviewsArray = [[NSMutableArray alloc] init];
    }
    return _subviewsArray;
}

+(ASAutoLayoutViewCode *)sharedInstane{
    static dispatch_once_t predicate;
    static ASAutoLayoutViewCode * sharedInstane;
    dispatch_once(&predicate, ^{
        sharedInstane = [[ASAutoLayoutViewCode alloc] init];
    });
    return sharedInstane;
}
@end
