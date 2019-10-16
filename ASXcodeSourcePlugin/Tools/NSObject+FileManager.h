//
//  NSObject+FileManager.h
//  ASXcodeSourcePlugin
//
//  Created by Sun Wen on 2019/10/16.
//  Copyright © 2019 Sun Wen. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FileManager)

+ (BOOL)saveFileToAppGroups:(NSURL *)filePath;

+ (NSMutableDictionary *)getAppGroupsFileDics;

@end

NS_ASSUME_NONNULL_END
