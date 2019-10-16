# ASXcodeSourcePlugin
![Language](https://img.shields.io/badge/language-Objective%20C%20-orange.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
#### 用于自动化根据规则自定义生成对应规则代码等。代码持续维护中，作为工作中的插件小工具使用。

## 可以做什么
- [x] UI控件添加到View
- [x] UI控件内容初始化
- [x] 生成Masonry布局
- [x] 属性懒加载
- [x] 自定义规则生成代码
- [x] 未完待续...

## 使用说明
- 如果之前编译过 ASXcodeSourcePlugin，清除 DrivedData
- 在这里安装：[源码地址](https://github.com/iAlexSun/ASXcodeSourceExtensioin)
- 源代码编译后把生成的App拖入应用程序即可
- 打开 Xcode 并选择文本
- 在 Editor 菜单中找到插件
- 你可以给每个插件都设置一个独立的快捷键

![](https://lc-9srqavax.cn-n1.lcfile.com/e486206e217660a6b101.png)
![](https://raw.githubusercontent.com/cyanzhong/xTextHandler/master/Screenshots/tips1.png)
![](https://lc-9srqavax.cn-n1.lcfile.com/75f3f53f3b5e580dcfbb.png)

## 生成代码规则
- 通过一个plist文件可获取文件内对应代码生成规则,plist包含规则对应类别名特定字段替换代码模板中的类名和属性名.例如`propertyName`,`className`为关键字在模板生成中会被替换成实际的类名和属性名。如:`@property(nonatomic,strong)UILabel *label;`在生成代码时`propertyName `会被替换为`label`。

![](http://lc-5z0sljjj.cn-n1.lcfile.com/30bc75a95cda8dc0041f/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-10-16%2013.59.42.png)
![](http://lc-5z0sljjj.cn-n1.lcfile.com/a37688e53b7aa66bca75/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-10-16%2014.00.02.png)
![](http://lc-5z0sljjj.cn-n1.lcfile.com/848cf35d4ae036138fb1/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-10-16%2014.00.15.png)

## 规则编写规范
- 每个规则需要按照如下格式生成

```
<key>自定义规则名称</key>
	<dict>
		<key>path</key>
		<string>插入位置</string>
		<key>rule</key>
		<array>
			<dict>
				<key>UILabel</key>
				<string>[self.view addSubview:self.propertyName];</string>
			</dict>
			<dict>
				<key>UIButton</key>
				<string>代码生成格式</string>
			</dict>
		</array>
	</dict>
```

- 自定义规则名称可以随意编写只是标识对应规则名称无实际作用

- 插入位置需要按照//+字符串生成,如//insertCode,避免插入位置中包含空格可能会出现无法识别等情况

- 代码生成格式可以把对应格式直接添加到plist文件中如:

```
[self.propertyName mas_makeConstraints:^(MASConstraintMaker *make)  {
   make.top.equalTo(self.<#UIView#>).offset(<#offset#>);        
	make.bottom.equalTo(self.<#UIView#>).offset(<#offset#>);     
	make.left.equalTo(self.<#UIView#>).offset(<#offset#>);        
	make.right.equalTo(self.<#UIView#>).offset(<#offset#>);       
	make.height.mas_equalTo(<#offset#>);        
	make.width.mas_equalTo(<#offset#>);    
}];
```

- 如果不是特定类生成特定代码则可以把rule设定成All即可,所有类可对应生成模板代码

![](http://lc-5z0sljjj.cn-n1.lcfile.com/e6dde0ba21ec64dabcce/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-10-16%2014.08.48.png)

## 规则文件上传

### 如果不上传则对应功能,内置规则plist文件如下：
#### 1.自动设置初始化控件
 - 在需要添加代码的地方插入标记例如(`//initSubNode`)并且选中需要自动生成代码的属性。 
 
 ![](https://lc-9srqavax.cn-n1.lcfile.com/f3f1714e1230f28e5bf0.jpg)

#### 2.自动设置懒加载方法
 
 - 在需要添加代码的地方插入`//setter&&getter`(注意一定要是这个格式的标记否则无法自动生成代码)并且选中需要自动生成代码的属性,例如`@property(nonatomic,strong)NSArray *testArray;`
 
 ![](https://lc-9srqavax.cn-n1.lcfile.com/3b1f0098025cce5fbaed.gif)

#### 3.自动设置Masonry自动布局
 - 在需要添加代码的地方可以插入你想要在标记下生成的代码并且选中需要自动生成代码的属性,例如标记为（`//addSubviews`,`//addConstraints`）,例如`@property(nonatomic,strong)UIView *testView;`
 
 ![](http://lc-9srqavax.cn-n1.lcfile.com/a07d71cc4bb147b3d326.gif)
 

### 如果上传则对应功能如下：
![](http://lc-5z0sljjj.cn-n1.lcfile.com/34af2b3de37266345b4c/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-10-16%2014.27.00.png)
![](http://lc-5z0sljjj.cn-n1.lcfile.com/c6cb720eed8999568c70/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-10-16%2014.27.25.png)

内置plist文件地址:[https://github.com/iAlexSun/ASXcodeSourceExtensioin/blob/master/RuleFile/rules.plist](https://github.com/iAlexSun/ASXcodeSourceExtensioin/blob/master/RuleFile/rules.plist)