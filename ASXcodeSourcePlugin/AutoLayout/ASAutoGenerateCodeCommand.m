//
//  SourceEditorCommand.m
//  ASXcodeSourcePlugin
//
//  Created by Sun Wen on 2018/5/17.
//  Copyright © 2018年 Sun Wen. All rights reserved.
//

#import "ASAutoGenerateCodeCommand.h"
#import "ASAutoGenerateCode.h"

@implementation ASAutoGenerateCodeCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler{
    NSString *identifier = invocation.commandIdentifier;
    if ([identifier hasPrefix:@"iAlexSun.ASXcodeSourceExtensioin"]) {
        [[ASAutoGenerateCode sharedInstane] autoGenerateCodeWithInvocation:invocation];
    }
    completionHandler(nil);
}

@end
