//
//  Request.h
//  KSWebRequest
//
//  Created by bing.hao on 15/9/10.
//  Copyright (c) 2015年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSWebRequest.h"

@interface RequestManager : NSObject

+ (RequestManager *)shared;

- (KSWebRequest *)createWebRequest;

@end
