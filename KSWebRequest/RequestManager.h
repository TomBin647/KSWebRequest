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

- (KSWebRequest *)defaultInstance:(NSString *)path params:(NSDictionary *)params;

@end

//回调
#define T KSWebRequestComplete
//获取一个WEB请求对象
#define __REQUEST(path, args) [[RequestManager shared] defaultInstance:path params:args]



/**
 * @brief 测试
 */
void w_Test(NSString *name, T t);