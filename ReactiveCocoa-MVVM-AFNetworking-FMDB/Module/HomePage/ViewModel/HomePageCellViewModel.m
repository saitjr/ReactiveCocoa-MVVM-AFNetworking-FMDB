//
//  HomePageCellViewModel.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "HomePageCellViewModel.h"

@interface HomePageCellViewModel ()

@end

@implementation HomePageCellViewModel

- (instancetype)initWithArticleModel:(ArticleModel *)articleModel {
    
    self = [super init];
    
    if (self) {
        self.articleModel = articleModel;
        [self setupData];
    }
    
    return self;
}

// 处理Model中的数据
// 这里的处理不是很复杂，仅仅作为例子
- (void)setupData {
    _titleText = self.articleModel.title;
    _subtitleText = self.articleModel.subtitle;
    _idText = self.articleModel.articleID.stringValue;
}

@end
