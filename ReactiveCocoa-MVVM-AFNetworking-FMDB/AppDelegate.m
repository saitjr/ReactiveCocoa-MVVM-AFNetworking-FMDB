//
//  AppDelegate.m
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/21/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "AppDelegate.h"
#import "FMDatabaseQueue+Extension.h"
#import "SQL.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self configFMDBTables];
    
    return YES;
}

// 创建需要的表
- (void)configFMDBTables {
    
    [[FMDatabaseQueue shareInstense] inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:createArticleSQL];
    }];
}

@end