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
    
    NSString *str = @"111111111";
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSString *filePath = [documents stringByAppendingPathComponent:@"111.plist"];
    [str writeToFile:filePath atomically:YES];
    
//    NSString *toPath = [documents stringByReplacingOccurrencesOfString:@"iAlexSun.ASXcodeSourceExtensioin" withString:@"iAlexSun.ASXcodeSourceExtensioin.ASXcodeSourcePlugin"];
  
}


@end
