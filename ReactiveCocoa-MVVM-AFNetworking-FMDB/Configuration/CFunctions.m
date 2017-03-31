//
//  CFunctions.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by saitjr on 4/1/17.
//  Copyright © 2017 tangjr. All rights reserved.
//

#import "CFunctions.h"

NSString const * GlobalErrorMessageKey = @"msg";

NSError* GlobalError(GlobalErrorType errorType, NSString *msg) {
    return [NSError errorWithDomain:@"com.saitjr.demo" code:errorType userInfo:@{GlobalErrorMessageKey : msg}];
}
