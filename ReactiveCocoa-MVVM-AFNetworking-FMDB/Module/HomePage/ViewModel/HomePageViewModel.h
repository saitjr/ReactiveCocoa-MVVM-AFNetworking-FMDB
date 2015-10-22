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

@interface HomePageViewModel : RequestViewModel <SQLInterface>

@property (strong, nonatomic) RACSignal *requestSignal;

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSArray *dataSource;

@end