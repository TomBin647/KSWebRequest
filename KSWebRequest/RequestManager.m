//
//  Request.m
//  KSWebRequest
//
//  Created by bing.hao on 15/9/10.
//  Copyright (c) 2015年 Bing. All rights reserved.
//

#import "RequestManager.h"

@interface RequestManager ()<KSWebRequestDelegate>

@end

@implementation RequestManager

+ (RequestManager *)shared
{
    static id _staticObject;
    if (_staticObject == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _staticObject = [RequestManager new];
        });
    }
    return _staticObject;
}

- (KSWebRequest *)defaultInstance:(NSString *)path params:(NSDictionary *)params
{
    static AFHTTPRequestOperationManager * __staticObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL * url = [NSURL URLWithString:@"http://ab.com"];
        __staticObject = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        __staticObject.responseSerializer = [AFJSONResponseSerializer serializer];
        //[AFHTTPResponseSerializer serializer];
        //        __staticObject.requestSerializer  = [AFJSONRequestSerializer serializer];
    });
    
    KSWebRequest * wr = [[KSWebRequest alloc] initWithManager:__staticObject delegate:self];
    
    [wr setPath:path];
    [wr.params setValuesForKeysWithDictionary:params];
    
    return wr;
}

- (void)webRequestOnBefore:(KSWebRequest *)sender method:(NSString *)method
{
    
}

- (NSError *)webRequestOnSuccessCheckJsonData:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"ErrorCode"]) {
        NSString     *domain   = @"abc.com";
        NSInteger    code      = [[responseObject objectForKey:@"ErrorCode"] integerValue];
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: [responseObject objectForKey:@"ErrorMessage"] };
        
        return [[NSError alloc] initWithDomain:domain code:code userInfo:userInfo];
    }
    return nil;
}

@end


/**
 * @brief 测试
 */
void w_Test(NSString *name, T t)
{
    [__REQUEST(@"/bb/test.jsp", nil) post:t];
}




