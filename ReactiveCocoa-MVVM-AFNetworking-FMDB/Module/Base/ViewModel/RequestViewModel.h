//
//  RequestViewModel.h
//  ReactiveCocoa-MVVM-AFNetworking-FMDB
//
//  Created by TangJR on 10/22/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "BaseViewModel.h"
#import <AFNetworking.h>

@interface RequestViewModel : BaseViewModel

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end
