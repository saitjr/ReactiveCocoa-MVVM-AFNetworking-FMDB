//
//  HomePageViewController.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageViewModel.h"
#import "HomePageCell.h"

@interface HomePageViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// vm
@property (strong, nonatomic) HomePageViewModel *viewModel;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self sendRequest];
}

// 发起请求
- (void)sendRequest {
    
    @weakify(self);
    [self.viewModel.requestSignal subscribeNext:^(NSArray *articles) {
        
        @strongify(self);
        // 请求完成后，刷新表格
        [self.tableView reloadData];
    } error:^(NSError *error) {
        // 如果请求失败，则根据error做出相应提示
    }];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [self configCell:cell indexPath:indexPath];
    return cell;
}

- (void)configCell:(HomePageCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    // 将数据赋值给cell的vm
    // cell接收到vm修改以后，就会触发初始时设置的信号量
    cell.viewModel = self.viewModel.dataSource[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.viewModel.dataSource.count;
}

#pragma mark - Lazy Load

- (HomePageViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [HomePageViewModel new];
    }
    return _viewModel;
}

@end
