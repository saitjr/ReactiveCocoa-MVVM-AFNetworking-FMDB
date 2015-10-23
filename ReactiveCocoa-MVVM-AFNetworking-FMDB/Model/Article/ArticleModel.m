//
//  ArticleModel.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "ArticleModel.h"
#import <MJExtension.h>

@implementation ArticleModel

// MJExtension中替换属性名称的方法
+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{@"articleId" : @"id"};
}

@end