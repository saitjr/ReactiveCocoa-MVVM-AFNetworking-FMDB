//
//  HomePageCellViewModel.h
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomePageCellViewModel : BaseViewModel

@property (copy, nonatomic) NSString *titleText;
@property (copy, nonatomic) NSString *authorText;
@property (copy, nonatomic) NSString *categoyrText;

@end