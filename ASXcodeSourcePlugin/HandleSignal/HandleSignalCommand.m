//
//  HandleSignalCommand.m
//  ASXcodeSourcePlugin
//
//  Created by Sun Wen on 2018/7/6.
//  Copyright © 2018年 Sun Wen. All rights reserved.
//

#import "HandleSignalCommand.h"
#import "HandelSignalCode.h"

@implementation HandleSignalCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    NSString *identifier = invocation.commandIdentifier;
    if ([identifier hasPrefix:@"iAlexSun.ASXcodeSourceExtensioin"]) {
        [HandelSignalCode handelSignalCodeWithInvocation:invocation];
    }
    completionHandler(nil);
}
@end
