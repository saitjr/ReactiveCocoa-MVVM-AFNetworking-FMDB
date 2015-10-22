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

- (void)setupData {
    
    _titleText = self.articleModel.title;
    _authorText = self.articleModel.authorname;
    _categoyrText = [@"分类:" stringByAppendingString:self.articleModel.categoryname];
}

@end