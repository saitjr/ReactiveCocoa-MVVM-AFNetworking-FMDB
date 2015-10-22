//
//  HomePageViewModel.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "HomePageViewModel.h"
#import "HomePageCellViewModel.h"
#import "FMDatabaseQueue+Extension.h"
#import "SQL.h"
#import <MJExtension.h>

@interface HomePageViewModel ()

@property (strong, nonatomic) NSMutableArray *articleViewModels;
@property (assign, nonatomic) BOOL isRefresh;

@end

@implementation HomePageViewModel

#pragma mark - SQLInterface

- (BOOL)saveData {
    
    __block BOOL isSuccess = NO;
    
    [[FMDatabaseQueue shareInstense] inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        for (HomePageCellViewModel *cellViewModel in self.dataSource) {
            
            ArticleModel *articleModel = cellViewModel.articleModel;
            
            isSuccess = [db executeUpdate:saveArticleSQL, articleModel.articleId, articleModel.title, articleModel.authorname, articleModel.categoryname];
            if (!isSuccess) {
                break;
            }
        }
        if (!isSuccess) {
            *rollback = YES;
            return;
        }
    }];
    
    return isSuccess;
}

- (BOOL)deleteData {
    
    __block BOOL isSuccess = NO;
    
    [[FMDatabaseQueue shareInstense] inDatabase:^(FMDatabase *db) {
        
        isSuccess = [db executeUpdate:deleteArticleSQL];
    }];
    
    return isSuccess;
}

- (void)loadData {
    
    [[FMDatabaseQueue shareInstense] inDatabase:^(FMDatabase *db) {
        
        FMResultSet *set = [db executeQuery:selectArticleSQL];
        while ([set next]) {
            ArticleModel *article = [ArticleModel new];
            article.title = [set objectForColumnName:@"title"];
            article.articleId = [set objectForColumnName:@"id"];
            article.authorname = [set objectForColumnName:@"authorname"];
            article.categoryname = [set objectForColumnName:@"categoryname"];
            HomePageCellViewModel *cellViewModel = [[HomePageCellViewModel alloc] initWithArticleModel:article];
            [self.articleViewModels addObject:cellViewModel];
        }
        [set close];
    }];
    self.dataSource = [self.articleViewModels copy];
}

#pragma mark - Getter / Setter

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
                
                if (self.isRefresh) {
                    [self deleteData];
                }
                BOOL isSuccess = [self saveData];
                NSLog(@"%d", isSuccess);
                
                [subscriber sendNext:self.dataSource];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
                [subscriber sendError:error];
                [self loadData];
            }];
            
            return [RACDisposable disposableWithBlock:^{
                
                [task cancel];
            }];
        }];
    }
    return _requestSignal;
}

- (BOOL)isRefresh {
    
    _isRefresh = self.currentPage == 0;
    
    return _isRefresh;
}

- (NSMutableArray *)articleViewModels {
    
    if (!_articleViewModels) {
        _articleViewModels = [NSMutableArray new];
    }
    return _articleViewModels;
}

@end