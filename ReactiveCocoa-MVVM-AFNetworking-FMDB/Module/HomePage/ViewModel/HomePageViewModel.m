//
//  HomePageViewModel.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "HomePageViewModel.h"
#import <MJExtension.h>

@implementation HomePageViewModel

- (RACSignal *)requestSignal {
    
    if (!_requestSignal) {
        
        _requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSDictionary *parameters = @{@"page": @(self.currentPage)};
            
            NSURLSessionDataTask *task = [self.sessionManager POST:@"http://www.brighttj.com/api/index.php/api/article/articleList" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSArray *articles = [ArticleModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"articleList"]];
                
                [subscriber sendNext:articles];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
                [subscriber sendError:error];
            }];
            
            return [RACDisposable disposableWithBlock:^{
                
                [task cancel];
            }];
        }];
    }
    return _requestSignal;
}

@end