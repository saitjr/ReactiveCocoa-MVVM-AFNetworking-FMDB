# ReactiveCocoa-MVVM-AFNetworking-FMDB

ReactiveCocoa-MVVM-AFNetworking-FMDB小项目框架设计

详细介绍见：

>   [小项目框架设计(ReactiveCocoa+MVVM+AFNetworking+FMDB)](http://www.brighttj.com/ios/ios-framework-reactivecocoa-mvvmafnetworking-fmdb.html)

## 工程目录

![](http://www.brighttj.com/wp-content/uploads/2015/10/ios-framework-reactivecocoa-mvvmafnetworking-fmdb-1.png)

1.  【Module】+【Model】
    
    在这个目录中，比较核心的是【Module】与【Model】，他们组成了整个MVVM框架。
    
    【Module】与【Model】均包含【Base】，其中有`BaseModel`、`BaseViewModel`、`BaseViewController`。在开发中，我还是习惯无论是否需要基类，都去写一个。难免开发之初就考虑到，也难免之后需求会变更。
    
2.  【Interface】接口
    
    这是借鉴了Java中的接口思想，目的是为了统一方法名。例如里面的`SQLInterface.h`文件，就是一个对数据进行CRUD操作的`protocol`，并且可以规定里面的方法是否必须实现。
    
3.  【Configuration】配置
    
    对项目的一些基本配置，如基本宏定义、常量、通知名，亦或是Cell的identifier。宏定义中一般包含项目基本属性，如：主色调、常用方法等。
    
    在提供的Demo中，我将SQL语句放在了`SQL.h`中，是因为SQL只有一个文件在引用，其中的定义方式是：
    
    ``` objective-c
    static NSString * const selectArticleSQL = @"SELECT * FROM article";
    ```
    
    而`NotificationNames.h`会在大部分文件中用到，所以使用`UIKIT_EXTERN`定义为了全局变量:
    
    ``` objective-c
    -----.h
    
    UIKIT_EXTERN NSString * const LoadAllNotification;
    
    -----.m
    
    NSString * const LoadAllNotification = @"LoadAllNotification";
    
    ```
    
    ​
    
4.  【Category】类目
    
    项目中没有打包的类目，例如给三方或系统类新增的一些方法。

## 最后

每个项目完后，都会有很多收获，有很多东西需要整理总结。写这篇博客的原因有两个：

原因之一：因为我在开发过程中踩了不少坑，可能开发到中途，发现框架设计不好。框架如何设计，并没有一个标准答案，而且设计思想，还需要在不断实践中得出，所以每次总结，是为了给自己看，也是为了帮到其他有同样困扰的朋友。

原因之二：也正是因为我不知道框架到底怎么样，所以写出来，让大家看看，都多多提出建议。谢谢。

