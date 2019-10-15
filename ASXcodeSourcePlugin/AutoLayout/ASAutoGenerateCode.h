
//  ASAutoGenerateCode.h
//  ASXcodeSourceExtensioin
//
//  Created by Sun Wen on 2018/5/17.
//  Copyright © 2018年 Sun Wen. All rights reserved.


#import <XcodeKit/XcodeKit.h>

@interface ASAutoGenerateCode : NSObject

+ (ASAutoGenerateCode *)sharedInstane;

- (void)autoGenerateCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation;

@end
