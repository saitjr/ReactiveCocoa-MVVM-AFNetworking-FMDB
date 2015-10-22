//
//  HomePageViewModel.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "HomePageViewModel.h"
#import "HomePageCellViewModel.h"
#import <MJExtension.h>

@interface HomePageViewModel ()

@property (strong, nonatomic) NSMutableArray *articleViewModels;
@property (assign, nonatomic) BOOL isRefresh;

@end

@implementation HomePageViewModel

- (RACSignal *)requestSignal {
    
    if (!_requestSignal) {
        
        _requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSDictionary *parameters = @{@"page": @(self.currentPage)};
            
            NSURLSessionDataTask *task = [self.sessionManager POST:@"http://www.brighttj.com/api/index.php/api/article/articleList" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSArray *articleArray = responseObject[@"data"][@"articleList"];
                for (NSDictionary *articleDictionary in articleArray) {
                    ArticleModel *articleModel = [ArticleModel objectWithKeyValues:articleDictionary];
                    HomePageCellViewModel *cellViewModel = [[HomePageCellViewModel alloc] initWithArticleModel:articleModel];
                    [self.articleViewModels addObject:cellViewModel];
                }
                self.dataSource = [self.articleViewModels copy];
                [subscriber sendNext:self.dataSource];
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

- (BOOL)isRefresh {
    
    return self.currentPage == 0;
}

- (NSMutableArray *)articleViewModels {
    
    if (!_articleViewModels) {
        _articleViewModels = [NSMutableArray new];
    }
    return _articleViewModels;
}

@end