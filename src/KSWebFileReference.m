//
//  KSWebFileReference.m
//  KSWebRequest
//
//  Created by bing.hao on 15/9/10.
//  Copyright (c) 2015年 Bing. All rights reserved.
//

#import "KSWebFileReference.h"

@implementation KSWebFileReference

- (void)upload:(NSString *)url fileObjects:(NSArray *)fileObjects
{
    [self upload:url params:nil fileObjects:fileObjects];
}

- (void)upload:(NSString *)url params:(NSDictionary *)params fileObjects:(NSArray *)fileObjects
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    id d = ^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < fileObjects.count; i++) {
            NSString * fd_n = [NSString stringWithFormat:@"file_data_%d", (int)i];
            if ([[fileObjects objectAtIndex:i] isKindOfClass:[NSData class]]) {
                [formData appendPartWithFormData:fileObjects[i] name:fd_n];
            } else {
                NSURL * fd_u = [NSURL fileURLWithPath:fileObjects[i]];
                [formData appendPartWithFileURL:fd_u name:fd_n error:nil];
            }
        }
    };

    id s = ^(AFHTTPRequestOperation *operation, id responseObject) {
        if (self.successUsing) {
            self.successUsing(responseObject);
        }
    };

    id f = ^(AFHTTPRequestOperation *operation, NSError *error) {
        if (self.failureUsing) {
            self.failureUsing(error);
        }
    };
    
    id p = ^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (self.progressUsing) {
            CGFloat p = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
            self.progressUsing(p);
        }
    };
    
    id r = [manager POST:url parameters:params constructingBodyWithBlock:d success:s failure:f];
    
    [r setUploadProgressBlock:p];
}

- (void)download:(NSString *)URLString output:(NSString *)path
{
    NSURLRequest           * rq = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    AFHTTPRequestOperation * ro = [[AFHTTPRequestOperation alloc] initWithRequest:rq];
    
    id s = ^(AFHTTPRequestOperation *operation, id responseObject) {
        if (self.successUsing) {
            self.successUsing(responseObject);
        }
    };
    
    id f = ^(AFHTTPRequestOperation *operation, NSError *error) {
        if (self.failureUsing) {
            self.failureUsing(error);
        }
    };
    
    id p = ^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (self.progressUsing) {
            CGFloat p = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
            self.progressUsing(p);
        }
    };
    
    [ro setOutputStream:[NSOutputStream outputStreamToFileAtPath:path append:NO]];
    [ro setDownloadProgressBlock:p];
    [ro setCompletionBlockWithSuccess:s failure:f];
    [ro start];
}

@end
