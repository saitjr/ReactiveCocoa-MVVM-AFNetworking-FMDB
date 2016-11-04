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

// 设置信号量，当cell的vm被重新赋值时，更新cell显示的数据
- (void)setupSignal {
    
    @weakify(self);
    [RACObserve(self, viewModel) subscribeNext:^(HomePageCellViewModel *viewModel) {
        
        // 使用strong修饰self，防止在self在使用中被释放
        @strongify(self);
        
        // vm已经将要显示的文本处理好了，在cell中直接赋值就行
        self.textLabel.text = viewModel.titleText;
        self.detailTextLabel.text = viewModel.idText;
    }];
}

@end
