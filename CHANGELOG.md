## 2.0.17

1. Migrated from the deprecated package_info plugin to package_info_plus.

## 2.0.16
FConfig add
1. dialogListSelectOfPaddingChild;
2. dialogListSelectOfWirePadding;
3. imageBrowseOfChildHeight;
4. imageBrowseOfChildWidth;
5. imageBrowseOfHeight;
6. imageBrowseOfWitch;
7. imageBrowseOfOperatingTopPadding
8. imageBrowseOfOperatingTop;
9. imageBrowseOfCloseSize;
10. imageBrowseOfSquare;
11. imageBrowseOfCloseColor;

## 2.0.15
FConfig add
1. dialogViewOfConfirmHeight
2. dialogViewOfTitleHeight
3. dialogViewOfTitleSize
4. dialogViewOfTextSize
5. dialogViewOfHorizontal
6. dialogViewOfVertical
7. dialogViewOfLoadWidth
8. dialogViewOfLoadTop
9. dialogViewOfTop
10. dialogViewOfMinHeight;

## 2.0.14+1
1. Plugin update

## 2.0.14
optimization TitleAction
1. titleActionOfIconSize
2. titleActionOfTxtSize
3. titleActionOfIconPadding
4. titleActionOfLeftRSize
5. titleActionOfTopBSize

## 2.0.13
optimization RespData
1. RespData.responseJson
2. FConfig add singleLineOfNameTxtStyle

## 2.0.12
optimization image
1. ImageBrowse
2. WrapperImage
3. dialogImageSelect

## 2.0.11+1
1. Fix data processing exception

## 2.0.11
Optimize Http add RespData static Attributes
1. responseJson
2. codeSuccess = 200
3. keyCode = "code"
4. keyData = "data"
5. keyLogin = "login"
6. keyHint = "success"
7. keyNext = "next"
8. keyBack = "back"
9. keyError = "error"
10. keyHasMore = "hasmore"
11. keyPageTotal = "page_total"

## 2.0.10
add InputDecorationUtil | Optimize EditText
## 2.0.9
Optimize http
## 2.0.8
Optimize http and ContainerEx
## 2.0.7
Fix empty security|Interceptor add version control
## 2.0.6
Optimize theme configuration Repair empty security
## 2.0.5
Optimize theme configuration Repair empty security
## 2.0.4
Optimize theme configuration Repair empty security
## 2.0.3
Optimize theme configuration Repair empty security
## 2.0.2
Project optimization
## 2.0.1
add Null safety
## 1.1.6+3
新增 SingleLine => singleLineOfRadius 配置

## 1.1.6+2
修复EditText和SingleLine 间距

## 1.1.6+1
修复屏幕适配初始化异常

## 1.1.6
增加ThemeVM->switchTheme 强制修改，解决初始化问题

ApiInterceptor 新增 extraSaveJson


## 1.1.5+5
response.extra 新增 key_json 字段 数据为初始 response.data

## 1.1.5+4
修改依赖问题

新增 MyBody =>cacheExtent

优化demo

## 1.1.5+3

修改UI效果

配置新增

pageHeight|pageWidth|myBodyOfSpace|checkboxOfBorderWidth

initFastDevelopOfRespData(processingExtend); Http 可以自定义初始化。

initFastDevelopOfHttp(baseOptions, parseJson, dioInit); RespData 可以处理扩展参数

initFastDevelopOfApiInterceptor(onRequest); ApiInterceptor 可以自定义onRequest

## 1.1.5+2
配置新增 listIntervalViewOfCacheExtent|gridIntervalViewOfCacheExtent

## 1.1.5+1
修复 ContainerEx 异常

## 1.1.5
配置新增 singleLineOfLeftRight|singleLineOfTopBottom|singleLineOfUrlSize;

SingleLine 新增 rightWidget

删除SingleLine.text改用SingleLine.normal

新增 theme_vm 主题配置
新增 example

## 1.1.4+2
修复 ContainerEx 宽高
优化 ScreenUtils 空异常
配置新增屏幕适配是否 启用

## 1.1.4+1
新增 ContainerEx
修复 CardEx 背景色

## 1.1.4
修复类型错误

## 1.1.3+3
修复配置类型错误

## 1.1.3+2
修复主题配色问题

## 1.1.3+1
初始化新增 editTextOfIconRightSpace
修复EditText 高度问题

## 1.1.3
新增配置
1. SConfigRadius
2. radiusOfCircle
3. 初始化新增 singleLineOfRightIconData
4. 修复iconTextOfIconBottom 配置无效

## 1.1.2+7
配置项 调整 FastDevelopConfig 改为单例

## 1.1.2+6
配置项优化

新增 titleWidget

## 1.1.2+4
配置项优化

新增 MyBody CheckBox

## 1.1.2+3
新增配置项

## 1.1.2+2
新增配置项

## 1.1.2+1
优化部分代码

## 1.1.2
修复fast_router 依赖问题

## 1.1.1+1
修复配置异常

## 1.1.1
增加说明，补充遗漏

## 1.1.0
修改依赖完整性

## 1.0.2
修改兼容性与配置项

## 1.0.1
showDialogCustom 新增offset和cushion

## 1.0.0
这是一个快速开发库，封装了一些常用的方法，使用前记得调用 FastDevelopConfig.init
