//
//  HomePageViewModel.h
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "RequestViewModel.h"
#import "ArticleModel.h"
#import "SQLInterface.h"
#import <ReactiveCocoa.h>

// vc的vm
// 因为需要进行数据缓存，所以遵循SQLInterface
// 因为需要进行网络请求，所以继承自RequestViewModel

@interface HomePageViewModel : RequestViewModel <SQLInterface>

@property (strong, nonatomic) RACSignal *requestSignal; ///< 网络请求信号量

@property (assign, nonatomic) NSInteger currentPage; ///< 当前页码
@property (strong, nonatomic) NSArray *dataSource; ///< tableView的数据源

@end