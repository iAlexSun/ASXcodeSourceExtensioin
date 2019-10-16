//
//  ViewController.m
//  ASXcodeSourceExtensioin
//
//  Created by Sun Wen on 2018/5/17.
//  Copyright © 2018年 Sun Wen. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+FileManager.h"

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
            if ([NSObject saveFileToAppGroups:[panel URLs].firstObject]) {
                NSLog(@"写入成功");
            }else{
                NSLog(@"写入失败");
            }
        }
    }];
}
@end
