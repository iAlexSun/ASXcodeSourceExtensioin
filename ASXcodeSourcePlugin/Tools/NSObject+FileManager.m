//
//  NSObject+FileManager.m
//  ASXcodeSourcePlugin
//
//  Created by Sun Wen on 2019/10/16.
//  Copyright © 2019 Sun Wen. All rights reserved.
//

#import "NSObject+FileManager.h"

#import <AppKit/AppKit.h>

static NSString *const AppGroupsIdentifier = @"group.ASXcodeSourcePlugin";
static NSString *const FilePath = @"Library/Application Support/rules.plist";

@implementation NSObject (FileManager)

+ (BOOL)saveFileToAppGroups:(NSURL *)filePath {
    NSURL *writePathURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:AppGroupsIdentifier];
    writePathURL = [writePathURL URLByAppendingPathComponent:FilePath];
    NSMutableDictionary *rulesDic = [NSMutableDictionary dictionaryWithContentsOfURL:filePath];
    return [rulesDic writeToFile:[writePathURL path] atomically:YES];
}

+ (NSMutableDictionary *)getAppGroupsFileDics {
      NSURL *path = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:AppGroupsIdentifier];
     NSURL *filePath = [path URLByAppendingPathComponent:FilePath];
     NSMutableDictionary *rulesDics = [NSMutableDictionary dictionaryWithContentsOfURL:filePath];
    return rulesDics;
}
@end
