//
//  KSWebFileReference.h
//  KSWebRequest
//
//  Created by bing.hao on 15/9/10.
//  Copyright (c) 2015年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^KSWebFileReferenceSuccess)(id res);
typedef void(^KSWebFileReferenceFailure)(NSError * err);
typedef void(^KSWebFileReferenceProgress)(double progress);

@interface KSWebFileReference : NSObject

@property (nonatomic, strong) KSWebFileReferenceSuccess  failureUsing;
@property (nonatomic, strong) KSWebFileReferenceFailure  successUsing;
@property (nonatomic, strong) KSWebFileReferenceProgress progressUsing;

/**
 * @brief 上传文件
 * @param url 地址
 * @param params 参数
 * @param paths 本地文件路径(NSURL)或文件对象(NSData)
 */
- (void)upload:(NSString *)url fileObjects:(NSArray *)fileObjects;
/**
 * @brief 上传文件
 * @param url 地址
 * @param params 参数
 * @param paths 本地文件路径(NSURL)或文件对象(NSData)
 */
- (void)upload:(NSString *)url params:(NSDictionary *)params fileObjects:(NSArray *)fileObjects;

/**
 * @brief 下载文件
 * @param URLString  网络文件地址
 * @param path 本地文件地址
 */
- (void)download:(NSString *)URLString output:(NSString *)path;

@end
