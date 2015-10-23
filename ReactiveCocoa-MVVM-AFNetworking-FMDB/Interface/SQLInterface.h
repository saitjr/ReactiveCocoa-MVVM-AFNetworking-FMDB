//
//  SQLInterface.h
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import <Foundation/Foundation.h>

// 数据缓存统一接口，在需要存储数据的类中遵循协议
@protocol SQLInterface <NSObject>

@optional
- (BOOL)saveData;
- (void)loadData;
- (BOOL)deleteData;
- (BOOL)updateData;

@end