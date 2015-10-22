//
//  SQLInterface.h
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SQLInterface <NSObject>

@optional
- (BOOL)saveData;
- (NSArray *)loadData;
- (BOOL)deleteData;
- (BOOL)updateData;

@end