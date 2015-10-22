//
//  HomePageCell.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "HomePageCell.h"
#import <ReactiveCocoa.h>

@implementation HomePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupSignal];
}

- (void)setupSignal {
    
    @weakify(self);
    [RACObserve(self, viewModel) subscribeNext:^(HomePageCellViewModel *viewModel) {
        
        @strongify(self);
        self.textLabel.text = viewModel.titleText;
        self.detailTextLabel.text = viewModel.authorText;
    }];
}

@end