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


static NSString *const kASMasonryFormater = @"    [_%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n        make.top.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.bottom.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.left.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.right.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.height.mas_equalTo(<#EVO_PIX_4#>);\n        make.width.mas_equalTo(<#EVO_PIX_4#>);\n    }];";

#define BtnFormat @"- (%@ *)%@ {\n    if (_%@ == nil) {\n        _%@ = [%@ buttonWithType:<#(UIButtonType)#>];\n    }\n    return _%@;\n}"

#define TableFormat @"- (%@ *)%@{\n    if (_%@ == nil) {\n        _%@ = [[%@ alloc] initWithFrame:<#(CGRect)#> style:<#(UITableViewStyle)#>];\n    }\n    return _%@;\n}"

#define CollectionFormat @"- (%@ *)%@{\n    if (_%@ == nil) {\n        _%@ = [[%@ alloc] initWithFrame:<#(CGRect)#> collectionViewLayout:<#(nonnull UICollectionViewLayout *)#>];\n    }\n    return _%@;\n}"
#define CommonFormat @"- (%@ *)%@{\n    if (_%@ == nil) {\n        _%@ = [[%@ alloc] init];\n    }\n    return _%@;\n}"

#define Command @"-(RACCommand *)%@{  \n   if (!_%@) {\n        @weakify(self);\n         _%@ = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id x) {\n            @strongify(self);\n            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {\n                [subscriber sendNext:x];\n                [subscriber sendCompleted];\n                return nil;\n            }];\n        }];\n    }\n    return _%@;\n}"

#define MasonryFormat @"    [_%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n        make.top.mas_equalTo(0);\n        make.left.mas_equalTo(0);\n        make.right.mas_equalTo(0);\n        make.height.mas_equalTo(0);\n    }];"

//#define PHEMasonryFormat @"    [_%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n        make.top.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.bottom.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.left.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.right.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.height.mas_equalTo(<#EVO_PIX_4#>);\n        make.width.mas_equalTo(<#EVO_PIX_4#>);\n    }];"

#define AddsubviewFormat @"    [<#UIView#> addSubview:self.%@];"


#define CommandSignal @"   [self.%@.executionSignals.flatten subscribeNext:^(id x) {\n       @strongify(self);\n\n   }];"

