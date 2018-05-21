//
//  ASConst.h
//  ASXcodeSourceExtensioin
//
//  Created by Sun Wen on 2018/5/17.
//  Copyright © 2018年 Sun Wen. All rights reserved.
//

#define BtnFormat @"- (%@ *)%@ {\n    if (_%@ == nil) {\n        _%@ = [%@ buttonWithType:<#(UIButtonType)#>];\n    }\n    return _%@;\n}"
#define TableFormat @"- (%@ *)%@{\n    if (_%@ == nil) {\n        _%@ = [[%@ alloc] initWithFrame:<#(CGRect)#> style:<#(UITableViewStyle)#>];\n    }\n    return _%@;\n}"
#define CollectionFormat @"- (%@ *)%@{\n    if (_%@ == nil) {\n        _%@ = [[%@ alloc] initWithFrame:<#(CGRect)#> collectionViewLayout:<#(nonnull UICollectionViewLayout *)#>];\n    }\n    return _%@;\n}"
#define CommonFormat @"- (%@ *)%@{\n    if (_%@ == nil) {\n        _%@ = [[%@ alloc] init];\n    }\n    return _%@;\n}"

#define MasonryFormat @"    [_%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n        make.top.mas_equalTo(0);\n        make.left.mas_equalTo(0);\n        make.right.mas_equalTo(0);\n        make.height.mas_equalTo(0);\n    }];"

#define PHEMasonryFormat @"    [_%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n        make.top.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.bottom.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.left.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n        make.right.equalTo(self.<#UIView#>).offset(<#EVO_PIX_4#>);\n\n        make.height.mas_equalTo(<#EVO_PIX_4#>);\n        make.width.mas_equalTo(<#EVO_PIX_4#>);\n        make.top.equalTo(self.<#UIView#>);\n        make.bottom.equalTo(self.<#UIView#>);\n\n        make.left.equalTo(self.<#UIView#>);\n        make.right.equalTo(self.<#UIView#>);\n        }];"

#define AddsubviewFormat @"    [<#UIView#> addSubview:self.%@];"
