//
//  KSWebRequest.h
//  KSWebRequest
//
//  Created by bing.hao on 15/9/10.
//  Copyright (c) 2015年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^KSWebRequestSuccess)(id res);
typedef void(^KSWebRequestFailure)(NSError * err);
typedef void(^KSWebRequestComplete)(id res, NSError * error);

#define KS_HTTP_METHOD_POST   @"POST"
#define KS_HTTP_METHOD_GET    @"GET"
#define KS_HTTP_METHOD_PUT    @"PUT"
#define KS_HTTP_METHOD_DELETE @"DELETE"

@protocol KSWebRequestDelegate;

@interface KSWebRequest : NSObject

/**
 * @brief 请求的地址
 */
@property (nonatomic, strong) NSString *path;
/**
 * @brief 请求参数
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *params;
/**
 * @brief delegate
 */
@property (nonatomic, weak) id<KSWebRequestDelegate> delegate;
/**
 * @brief AFHTTPRequestOperation
 */
@property (nonatomic, strong, readonly) AFHTTPRequestOperation *current;
/**
 * @brief AFHTTPRequestOperationManager
 */
@property (nonatomic, weak) AFHTTPRequestOperationManager *manager;


/**
 * @brief 初始化方法
 */
- (id)initWithManager:(AFHTTPRequestOperationManager *)manager delegate:(id)delegate;

/**
 * @brief post请求
 */
- (void)post:(KSWebRequestComplete)complete;
/**
 * @brief get请求
 */
- (void)get:(KSWebRequestComplete)complete;
/**
 * @brief put请求
 */
- (void)put:(KSWebRequestComplete)complete;
/**
 * @brief delete请求
 */
- (void)del:(KSWebRequestComplete)complete;
/**
 * @brief 发送一个请求
 * @param method 请求类型
 * @param success 完成回调
 * @param failure 失败回调
 */
- (void)sendWithMethod:(NSString *)method success:(KSWebRequestSuccess)success failure:(KSWebRequestFailure)failure;

@end


@protocol KSWebRequestDelegate <NSObject>

@optional
/**
 * @brief 请求之前调用
 */
- (void)webRequestOnBefore:(KSWebRequest *)sender;
/**
 * @brief 请求正确调用之后查看一下数据是否出错
 */
- (NSError *)webRequestOnSuccessCheckJsonData:(id)responseObject;

@end