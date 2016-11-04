//
//  ArticleModel.h
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleModel : BaseModel

@property (copy, nonatomic) NSNumber *articleId;
@property (copy, nonatomic) NSString *title;

@end
