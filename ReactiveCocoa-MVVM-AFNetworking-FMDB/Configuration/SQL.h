//
//  SQL.h
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const createArticleSQL = @"CREATE TABLE IF NOT EXISTS article (id INT, title VARCHAR, authorname VARCHAR, categoryname VARCHAR)";

static NSString * const saveArticleSQL = @"INSERT INTO article VALUES (?, ?, ?, ?)";
static NSString * const deleteArticleSQL = @"DELETE FROM article";
static NSString * const selectArticleSQL = @"SELECT * FROM article";