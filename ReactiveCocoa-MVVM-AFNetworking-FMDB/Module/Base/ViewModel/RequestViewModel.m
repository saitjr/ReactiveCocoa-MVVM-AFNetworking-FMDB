//
//  RequestViewModel.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "RequestViewModel.h"

@implementation RequestViewModel

- (AFHTTPSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}

- (void)dealloc {
    
    [self.sessionManager invalidateSessionCancelingTasks:YES];
}

@end
