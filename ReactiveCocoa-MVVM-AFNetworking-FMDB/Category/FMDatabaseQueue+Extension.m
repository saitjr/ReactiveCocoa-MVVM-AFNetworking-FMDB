//
//  FMDatabaseQueue+Extension.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "FMDatabaseQueue+Extension.h"
#import "define.h"

#define DB_PATH [NSString stringWithFormat:@"%@/%@.db", ST_DOCUMENT_DIRECTORY, ST_APP_NAME]

@implementation FMDatabaseQueue (Extension)

+ (instancetype)shareInstense {
    
    static FMDatabaseQueue *queue = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 根据路径，创建数据库
        queue = [FMDatabaseQueue databaseQueueWithPath:DB_PATH];
    });
    
    return queue;
}

@end