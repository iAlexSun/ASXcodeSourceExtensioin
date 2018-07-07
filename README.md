# ASXcodeSourcePlugin

## 介绍
#### 用于自动化生成Masnory代码和实现懒加载等。代码持续维护中，作为工作中的插件小工具使用。

## 下载安装
- 如果之前编译过 ASXcodeSourcePlugin，清除 DrivedData
- 在这里安装：[源码地址](https://github.com/iAlexSun/ASXcodeSourceExtensioin)
- 打开 Xcode 并选择文本
- 在 Editor 菜单中找到插件
- 你可以给每个插件都设置一个独立的快捷键

## 插件设置
![](https://raw.githubusercontent.com/cyanzhong/xTextHandler/master/Screenshots/tips1.png)
![](http://lc-9srqavax.cn-n1.lcfile.com/75f3f53f3b5e580dcfbb.png)

## 如何使用
### 自动设置懒加载方法
 
 - 在需要添加代码的地方插入`#pragma mark - Get`(注意一定要是这个格式的标记否者无法社会您构成代码),例如`@property(nonatomic,strong)NSArray *testArray;`
 - 选中选择已经设置好快捷键的插件,之后会在`#pragma mark - Get`下方出现懒加载.也可以支持批量设置自动生成代码.
 ![](http://lc-9srqavax.cn-n1.lcfile.com/3b1f0098025cce5fbaed.gif)


### 自动设置Masonry自动布局
 - 在需要添加代码的地方插入`#pragma mark - Add`,`#pragma mark - Masonry`,例如`@property(nonatomic,strong)UIView *testView;`
 - 选中选择已经设置好快捷键的插件,之后会在`#pragma mark - Masonry `,`#pragma mark - Add`下方出现懒加载.
 - 也可以支持批量设置自动生成代码.
 
 ![](http://lc-9srqavax.cn-n1.lcfile.com/a07d71cc4bb147b3d326.gif)

