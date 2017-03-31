//
//  CFunctions.h
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by saitjr on 4/1/17.
//  Copyright © 2017 tangjr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GlobalErrorType) {
    GlobalErrorType_Request,    ///< 请求出错
    GlobalErrorType_LoadFile,   ///< 加载文件出错
    GlobalErrorType_Database    ///< 数据库错误
};
FOUNDATION_EXTERN NSString const * GlobalErrorMessageKey;

FOUNDATION_EXTERN NSError* GlobalError(GlobalErrorType errorType, NSString *msg);
