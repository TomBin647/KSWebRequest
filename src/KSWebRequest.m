//
//  KSWebRequest.m
//  KSWebRequest
//
//  Created by bing.hao on 15/9/10.
//  Copyright (c) 2015年 Bing. All rights reserved.
//

#import "KSWebRequest.h"
#import <objc/runtime.h>

@implementation KSWebRequest

- (id)initWithManager:(AFHTTPRequestOperationManager *)manager delegate:(id)delegate
{
    self = [super init];
    if (self) {
        _params   = [NSMutableDictionary new];
        _manager  = manager;
        _delegate = delegate;
    }
    return self;
}

- (void)post:(KSWebRequestComplete)complete
{
    [self sendWithMethod:KS_HTTP_METHOD_POST complete:complete];
}

- (void)get:(KSWebRequestComplete)complete
{
    [self sendWithMethod:KS_HTTP_METHOD_GET complete:complete];
}

- (void)put:(KSWebRequestComplete)complete
{
    [self sendWithMethod:KS_HTTP_METHOD_PUT complete:complete];
}

- (void)del:(KSWebRequestComplete)complete
{
    [self sendWithMethod:KS_HTTP_METHOD_DELETE complete:complete];
}

- (void)sendWithMethod:(NSString *)method complete:(KSWebRequestComplete)complete
{
    [self sendWithMethod:method success:^(id res) {
        if (complete) {
            complete(res, nil);
        }
    } failure:^(NSError *err) {
        if (complete) {
            complete(nil, err);
        }
    }];
}

- (void)sendWithMethod:(NSString *)method success:(KSWebRequestSuccess)success failure:(KSWebRequestFailure)failure
{
    NSAssert(!self.current, @"请保证一个对象一次请求.");
    
    if ([self.delegate respondsToSelector:@selector(webRequestOnBefore:method:)]) {
        [self.delegate webRequestOnBefore:self method:method];
    }

    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.manager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:self.path relativeToURL:self.manager.baseURL] absoluteString] parameters:self.params error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.manager.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return;
    }
    NSLog(@"%@", request);
    id sucessUsing = ^(AFHTTPRequestOperation * operation, id responseObject){
        
        if ([self.delegate respondsToSelector:@selector(webRequestOnSuccessCheckJsonData:)]) {
            NSError *error = [self.delegate webRequestOnSuccessCheckJsonData:responseObject];
            if (error) {
                failure(error);
                return;
            }
        }
        if (success) {
            success(responseObject);
        }
    };
    
    id failureUsing = ^(AFHTTPRequestOperation * peration, NSError * error){
        
        NSLog(@"%@", error);

        if ([self.manager.requestSerializer isMemberOfClass:[AFJSONResponseSerializer class]]) {
            NSData *data = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }

        if (failure) {
            failure(error);
        }
    };
    
    _current = [self.manager HTTPRequestOperationWithRequest:request success:sucessUsing failure:failureUsing];
    
    [self.manager.operationQueue addOperation:_current];
}

- (void)dealloc
{
    _current = nil;
}

@end
