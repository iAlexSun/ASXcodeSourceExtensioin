//
//  SourceEditorCommand.m
//  ASXcodeSourcePlugin
//
//  Created by Sun Wen on 2018/5/17.
//  Copyright © 2018年 Sun Wen. All rights reserved.
//

#import "SourceEditorCommand.h"
#import "ASAutoLayoutViewCode.h"
@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    NSString *identifier = invocation.commandIdentifier;
    if ([identifier hasPrefix:@"iAlexSun.ASXcodeSourceExtensioin"]) {
        [ASAutoLayoutViewCode addAutoLayoutViewCodeWithInvocation:invocation];
    }
    completionHandler(nil);
}

@end
