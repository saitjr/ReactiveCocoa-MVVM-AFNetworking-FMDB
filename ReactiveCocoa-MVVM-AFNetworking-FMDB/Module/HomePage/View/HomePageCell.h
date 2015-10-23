//
//  HomePageCell.h
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageCellViewModel.h"

@interface HomePageCell : UITableViewCell

// cell的VM
@property (strong, nonatomic) HomePageCellViewModel *viewModel;

@end
