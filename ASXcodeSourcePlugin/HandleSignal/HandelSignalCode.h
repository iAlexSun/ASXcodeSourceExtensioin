
//  ASAutoLayoutViewCode.h
//  ASXcodeSourceExtensioin
//
//  Created by Sun Wen on 2018/5/17.
//  Copyright © 2018年 Sun Wen. All rights reserved.


#import <XcodeKit/XcodeKit.h>

@interface HandelSignalCode : NSObject
/**
 处理RAC信号的问题

 @param invocation 获取选中的字符流
 */
+ (void)handelSignalCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation;

@end
