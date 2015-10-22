//
//  HomePageCellViewModel.h
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "BaseViewModel.h"
#import "ArticleModel.h"

@interface HomePageCellViewModel : BaseViewModel

@property (strong, nonatomic) ArticleModel *articleModel;

@property (copy, nonatomic, readonly) NSString *titleText;
@property (copy, nonatomic, readonly) NSString *authorText;
@property (copy, nonatomic, readonly) NSString *categoyrText;

- (instancetype)initWithArticleModel:(ArticleModel *)articleModel;

@end