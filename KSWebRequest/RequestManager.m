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

- (KSWebRequest *)createWebRequest
{
    static AFHTTPRequestOperationManager * __staticObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL * url = [NSURL URLWithString:@"http://betaapis.xuexiba.com"];
        __staticObject = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        __staticObject.responseSerializer = [AFJSONResponseSerializer serializer];
        //[AFHTTPResponseSerializer serializer];
        //        __staticObject.requestSerializer  = [AFJSONRequestSerializer serializer];
    });
    
    KSWebRequest * wr = [[KSWebRequest alloc] initWithManager:__staticObject delegate:self];
    
    
    return wr;
}

- (void)webRequestOnBefore:(KSWebRequest *)sender
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
