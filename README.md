# ASXcodeSourcePlugin
![Language](https://img.shields.io/badge/language-Objective%20C%20-orange.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
#### 用于自动化生成Masnory代码和实现懒加载等。代码持续维护中，作为工作中的插件小工具使用。

## 可以做什么
- [x] UI控件添加到View
- [x] UI控件内容初始化
- [x] 生成Masonry布局
- [x] 属性懒加载
- [x] 未完待续...

## 使用说明
- 如果之前编译过 ASXcodeSourcePlugin，清除 DrivedData
- 在这里安装：[源码地址](https://github.com/iAlexSun/ASXcodeSourceExtensioin)
- 源代码编译后把生成的App拖入应用程序即可
- 打开 Xcode 并选择文本
- 在 Editor 菜单中找到插件
- 你可以给每个插件都设置一个独立的快捷键


![](http://lc-9srqavax.cn-n1.lcfile.com/6c8767c46a0439643373.png)
![](http://lc-9srqavax.cn-n1.lcfile.com/e486206e217660a6b101.png)
![](https://raw.githubusercontent.com/cyanzhong/xTextHandler/master/Screenshots/tips1.png)
![](http://lc-9srqavax.cn-n1.lcfile.com/75f3f53f3b5e580dcfbb.png)

## 自动设置初始化控件
 - 在需要添加代码的地方插入标记例如(`#pragma mark - init`)并且选中需要自动生成代码的属性。由于自己业务原因我将标记修改为[self bindViewModel]方法,这样可以无需插入任何代码就可以一键生成需要的代码。
 - 支持批量设置自动生成代码.
 
 ![](http://lc-9srqavax.cn-n1.lcfile.com/f3f1714e1230f28e5bf0.jpg)

## 自动设置懒加载方法
 
 - 在需要添加代码的地方插入`#pragma mark - Getter`(注意一定要是这个格式的标记否则无法自动生成代码)并且选中需要自动生成代码的属性,例如`@property(nonatomic,strong)NSArray *testArray;`
 - 选中选择已经设置好快捷键的插件,之后会在`#pragma mark - Getter`下方出现懒加载
 - 支持批量设置自动生成代码.
 
 ![](http://lc-9srqavax.cn-n1.lcfile.com/3b1f0098025cce5fbaed.gif)


## 自动设置Masonry自动布局
 - 在需要添加代码的地方可以插入你想要在标记下生成的代码并且选中需要自动生成代码的属性,例如标记为（`#pragma mark - Add`,`#pragma mark - Masonry`）,例如`@property(nonatomic,strong)UIView *testView;`
 - 选中选择已经设置好快捷键的插件,之后会在标记(`#pragma mark - Masonry `,`#pragma mark - Add`)下方出现懒加载.
 - 也可以支持批量设置自动生成代码.
 
 ![](http://lc-9srqavax.cn-n1.lcfile.com/a07d71cc4bb147b3d326.gif)
 

## 如何修改插入位置
- 可以通过修改标记内容即可修改自动插入内容部分,如果没有在代码中插入默认的代码标记,无法自动生成代码,默认需要插入 `#pragma mark - Getter`或 ` - (void)addConstraints`或` - (void) addSubviews`或` - (void) addSubviews`或`[self bindViewModel]`也可以全部插入;

![](http://lc-9srqavax.cn-n1.lcfile.com/2bbe16ea65ffb711590e.png)

