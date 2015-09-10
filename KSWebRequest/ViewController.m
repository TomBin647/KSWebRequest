//
//  ViewController.m
//  KSWebRequest
//
//  Created by bing.hao on 15/9/10.
//  Copyright (c) 2015年 Bing. All rights reserved.
//

#import "ViewController.h"
#import "RequestManager.h"
#import "KSWebFileReference.h"

@interface ViewController ()
{
//    KSWebRequest *request;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    KSWebRequest *request = [[RequestManager shared] createWebRequest];
//    
//    [request.params setObject:@"111" forKey:@"password"];
//    [request.params setObject:@"" forKey:@"username"];
//    [request setPath:@"/v1/user/login"];
//    [request post:^(id res, NSError *error) {
//        NSLog(@"%@", res);
//        NSLog(@"%@", error);
//    }];
//    
//
//    NSString *output = [NSString stringWithFormat:@"%@/1.jpg", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
//    NSString *URLString = @"http://60.195.251.72/tsingda/M00/00/F1/ooYBAFVuxJyAKbPQAAnyhRFZruE309.png";
//    
//    NSLog(@"%@", output);
//    KSWebFileReference * fileReference = [KSWebFileReference new];
//    
//    [fileReference setProgressUsing:^(CGFloat progresss) {
//        NSLog(@"%f", progresss);
//    }];
//    [fileReference setFailureUsing:^(id res) {
//        NSLog(@"%@", res);
//    }];
//    [fileReference setSuccessUsing:^(NSError *err) {
//        NSLog(@"%@", err);
//    }];
//    [fileReference download:URLString output:output];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
