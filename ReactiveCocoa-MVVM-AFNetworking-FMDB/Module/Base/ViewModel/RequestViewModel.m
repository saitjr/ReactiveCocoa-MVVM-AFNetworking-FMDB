//
//  RequestViewModel.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "RequestViewModel.h"

@implementation RequestViewModel

// 懒加载
- (AFHTTPSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = 5;
    }
    return _sessionManager;
}

// 在对象销毁时，别忘了取消已经在队列中的请求
- (void)dealloc {
    
    [self.sessionManager invalidateSessionCancelingTasks:YES];
}

@end
