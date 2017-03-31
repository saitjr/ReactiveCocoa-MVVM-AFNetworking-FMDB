//
//  HomePageCellViewModel.h
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "BaseViewModel.h"
#import "ArticleModel.h"

// cell的vm
// 无需网络请求，所以继承BaseViewModel即可
@interface HomePageCellViewModel : BaseViewModel

@property (strong, nonatomic) ArticleModel *articleModel;

@property (copy, nonatomic, readonly) NSString *titleText;
@property (copy, nonatomic, readonly) NSString *subtitleText;
@property (copy, nonatomic, readonly) NSString *idText;

- (instancetype)initWithArticleModel:(ArticleModel *)articleModel;

@end
