//
//  ASConst.h
//  ASXcodeSourceExtensioin
//
//  Created by Sun Wen on 2018/5/17.
//  Copyright © 2018年 Sun Wen. All rights reserved.
//

static NSString *const kGetterFormater = @"#pragma mark - Getter";
static NSString *const kAddSubviewFormater = @"#pragma mark - AddSubview";
static NSString *const kMasonryFormater = @"#pragma mark - Masonry";
static NSString *const kCommand = @"Command";
static NSString *const kButton =  @"Button";
static NSString *const kView = @"View";
static NSString *const kLabel = @"Label";
static NSString *const kUIImageView = @"UIImageView";
static NSString *const kTextField = @"TextField";
static NSString *const kTextView = @"TextView";

//自定义内容格式
static NSString *const kASMasonryFormater = @"    [self.%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n        make.top.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.bottom.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.left.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.right.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.height.mas_equalTo(<#EVO_PIX_4#>);\n        make.width.mas_equalTo(<#EVO_PIX_4#>);\n    }];";

static NSString *const kASCommandFormater = @"-(RACCommand *)%@{  \n   if (!_%@) {\n        @weakify(self);\n         _%@ = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id x) {\n            @strongify(self);\n            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {\n                [subscriber sendNext:x];\n                [subscriber sendCompleted];\n                return nil;\n            }];\n        }];\n    }\n    return _%@;\n}";

static NSString *const kASAddsubviewFormater = @"    [<#UIView#> addSubview:self.%@];";

static NSString *const kASCommonFormater = @"- (%@ *)%@{\n    if (_%@ == nil) {\n        _%@ = [[%@ alloc] init];\n    }\n    return _%@;\n}";


#define CommandSignal @"   [self.%@.executionSignals.flatten subscribeNext:^(id x) {\n       @strongify(self);\n\n   }];"

