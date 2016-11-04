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

@property (strong, nonatomic) NSMutableArray *articleViewModels; ///< 这个属性主要存储的是文章的vm，上拉加载的时候追加，下拉刷新的时候清空。防止直接修改dataSource
@property (assign, nonatomic) BOOL isRefresh; ///< 是否是刷新(用于处理数据缓存与dataSource)

@end

@implementation HomePageViewModel

#pragma mark - SQLInterface

- (BOOL)saveData {
    
    // 需要在block中进行修改变量值，所以用__block修饰
    __block BOOL isSuccess = NO;
    
    // 批量操作，选择事务
    [[FMDatabaseQueue shareInstense] inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        for (HomePageCellViewModel *cellViewModel in self.dataSource) {
            
            ArticleModel *articleModel = cellViewModel.articleModel;
            
            // 存储
            isSuccess = [db executeUpdate:saveArticleSQL, articleModel.articleId, articleModel.title];
            // 如果有失败，则停止，跳出循环
            if (!isSuccess) {
                break;
            }
        }
        // 如果遇到失败，则回滚，存储失败
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
        
        // 读取数据
        FMResultSet *set = [db executeQuery:selectArticleSQL];
        
        // 循环读取，直到读完
        while ([set next]) {
            ArticleModel *article = [ArticleModel new];
            article.title = [set objectForColumnName:@"title"];
            article.articleId = [set objectForColumnName:@"id"];
            HomePageCellViewModel *cellViewModel = [[HomePageCellViewModel alloc] initWithArticleModel:article];
            [self.articleViewModels addObject:cellViewModel];
        }
        // 关闭结果集
        [set close];
    }];
    // 读取完后重新赋值给dataSource
    self.dataSource = [self.articleViewModels copy];
}

#pragma mark - Getter / Setter

// 采用懒加载的方式来配置网络请求
- (RACSignal *)requestSignal {
    
    if (!_requestSignal) {
        
        @weakify(self);
        _requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            @strongify(self);
            
            // 配置网络请求参数
            NSDictionary *parameters = @{@"page": @(self.currentPage)};
            
            // 发起请求
            NSURLSessionDataTask *task = [self.sessionManager GET:@"https://s0.jianshuapi.com/v2/trending/daily.json?app%5Bname%5D=hugo&app%5Bversion%5D=2.11.2&auth1=8505f184ed6b87f1ffa152474174c17c&count=10&device%5Bguid%5D=63926467-1049-49DF-8CDA-15D8E596E742&limit=10&page=1&timestamp=1478249390" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                // 将请求下来的字典->模型
                NSArray *articleArray = responseObject;
                for (NSDictionary *articleDictionary in articleArray) {
                    ArticleModel *articleModel = [ArticleModel objectWithKeyValues:articleDictionary];
                    // 根据模型，初始化cell的vm
                    HomePageCellViewModel *cellViewModel = [[HomePageCellViewModel alloc] initWithArticleModel:articleModel];
                    // 将cell的vm存入数组
                    [self.articleViewModels addObject:cellViewModel];
                }
                // 完成数据处理后，赋值给dataSource
                self.dataSource = [self.articleViewModels copy];
                
                // 如果是刷新操作，则删除数据库中的旧数据
                // 这里也可以采用存入部分新数据的方式，全部删除可能在效率方面不是很好
                if (self.isRefresh) {
                    [self deleteData];
                }
                // 存入新数据
                [self saveData];
                
                [subscriber sendNext:self.dataSource];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
                // 如果网络请求出错，则加载数据库中的旧数据
                [self loadData];
                [subscriber sendNext:self.dataSource];
                [subscriber sendError:error];
            }];
            
            // 在信号量作废时，取消网络请求
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
