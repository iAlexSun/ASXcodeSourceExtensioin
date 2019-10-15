//
//  ViewController.m
//  ASXcodeSourceExtensioin
//
//  Created by Sun Wen on 2018/5/17.
//  Copyright © 2018年 Sun Wen. All rights reserved.
//

#import "ViewController.h"
@interface ViewController()

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)sender:(NSButton *)sender {
    [self showPanel];
}

- (void)showPanel {
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:NO];  //是否允许多选file
    
    [panel beginWithCompletionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            if ([self saveFileToAppGroups:[panel URLs].firstObject]) {
                NSLog(@"写入成功");
            }else{
                NSLog(@"写入失败");
            }
        }
    }];
}

- (BOOL)saveFileToAppGroups:(NSURL *)filePath {
    NSURL *writePathURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.ASXcodeSourcePlugin"];
    writePathURL = [writePathURL URLByAppendingPathComponent:@"rules.plist"];
    NSMutableDictionary *rulesDic = [NSMutableDictionary dictionaryWithContentsOfURL:filePath];
    BOOL isSucess = [rulesDic writeToFile:[writePathURL path] atomically:YES];
    return isSucess;
}

@end
