//
//  URLConnectionHelper.m
//  好梦学车
//
//  Created by haomeng on 2017/6/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "URLConnectionHelper.h"

@implementation URLConnectionHelper

+ (URLConnectionHelper *)shareDefaulte{
    static URLConnectionHelper *sharedDefaulte;
    if (!sharedDefaulte) {
        sharedDefaulte = [[URLConnectionHelper alloc] init];
    }
    return sharedDefaulte;
}

- (void)getPostDataWithUrl:(NSString *)urlstr andConnectModel:(URLConnectionModel *)model andSuccessBlock:(void (^)(NSData *))successedBlock andFailedBlock:(void (^)(NSError *))failedBlock{
    NSDictionary *dic = @{
                          @"isRand":model.isRand,
                          @"serviceName": model.serviceName,
                          @"course": model.course,
                          @"Take": @0,
                          @"Skip": @0,
                          @"PageId": @0,
                          @"header": @{
                                  @"SSOST":@"",
                                  @"cmd": @"",
                                  @"deviceId": @"a35d5fd0-bc80-3c2c-90f9-131a6b0191fb",
                                  @"deviceName": @"vivo X3L",
                                  @"osName": @"Android",
                                  @"osVersion": @"4.3",
                                  @"source": @"3",
                                  @"versionCode": @"22"
                                  },
                          @"uncheck": @"sign"
                          };
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (model.type) {
        [mutDic setObject:model.type forKey:@"type"];
    }
    NSDictionary *newDic = [NSDictionary dictionaryWithDictionary:mutDic];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:newDic forKey:@"data"];
    
//    [data setObject:@"sign" forKey:@"uncheck"];
    
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
//    NSURL *url = [NSURL URLWithString:urlstr];
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:8088/openApi/app/gateway.htm",PUBLIC_LOCATION]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            successedBlock(data);
        }else{
            failedBlock(error);
        }
    }];
    [dataTask resume];
}

- (void)loadTokenPostDataWithUrl:(NSString *)urlStr andDic:(NSDictionary *)dic andSuccessBlock:(void (^)(NSArray *))successBlock andFiledBlock:(void (^)(NSError *))failedBlock{
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    NSRange range = {0,jsonStr.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\"withString:@""options:NSLiteralSearch range:range3];
    
    
    NSData *jsonData = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
    [request setValue:token forHTTPHeaderField:@"HMAuthorization"];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arrData = [jsonDict objectForKey:@"data"];
            NSLog(@"--:%@",arrData);
            if ([arrData isEqual:[NSNull new]]) {
                return ;
            }
            if (arrData == nil || arrData.count < 1) {
                
            }else{
                
            }
            if (successBlock) {
                successBlock(arrData);
            }
            
        }else{
            if (failedBlock) {
                failedBlock(error);
            }
        }
    }];
    [dataTask resume];
    
}

- (void)loadPostDataWithUrl:(NSString *)urlStr andDic:(NSDictionary *)dic andSuccessBlock:(void(^)(NSArray *data))successBlock andFiledBlock:(void(^)(NSError *error))failedBlock{
    
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    NSRange range = {0,jsonStr.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\"withString:@""options:NSLiteralSearch range:range3];
    
    
    NSData *jsonData = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    
 
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *str = [jsonDict objectForKey:@"code"];
            if ([str isEqualToString:@"200"]) {
                NSArray *arrData = [jsonDict objectForKey:@"data"];
                if ([arrData isEqual:[NSNull new]]) {
                    arrData = @[];
                }
                if ([arrData isKindOfClass:[NSString class]]) {
                    arrData = @[arrData];
                }
                if (successBlock) {
                    successBlock(arrData);
                }
            }else{
                if (failedBlock) {
                    failedBlock(error);
                }
            }
        }else{
            if (failedBlock) {
                failedBlock(error);
            }
        }
    }];
    [dataTask resume];
}

- (void)loadPostTwoDataWithUrl:(NSString *)urlStr andDic:(NSDictionary *)dic andSuccessBlock:(void (^)(NSArray *))successBlock andFiledBlock:(void (^)(NSError *))failedBlock{
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    NSRange range = {0,jsonStr.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\"withString:@""options:NSLiteralSearch range:range3];
    
    
    NSData *jsonData = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *str = [jsonDict objectForKey:@"code"];
            if ([str isEqualToString:@"200"]) {
                NSArray *arrData = [jsonDict objectForKey:@"data"];
                if ([arrData isEqual:[NSNull new]]) {
                    arrData = @[];
                }
                if ([arrData isKindOfClass:[NSString class]]) {
                    arrData = @[arrData];
                }
                if (successBlock) {
                    successBlock(arrData);
                }
            }else{
                if (failedBlock) {
                    failedBlock(error);
                }
            }
        }else{
            if (failedBlock) {
                failedBlock(error);
            }
        }
    }];
    [dataTask resume];
}

- (void)loadPostDataWithUrl:(NSString *)urlStr andDic:(NSDictionary *)dic andSuccessBlock:(void (^)(NSArray *))successBlock andDicFiledBlock:(void (^)(NSDictionary *))failedBlock{
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    NSRange range = {0,jsonStr.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\"withString:@""options:NSLiteralSearch range:range3];
    
    
    NSData *jsonData = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arrData = [jsonDict objectForKey:@"data"];
            NSLog(@"--:%@",arrData);
            BOOL success = [jsonDict objectForKey:@"success"];
            if (!success) {
                if (failedBlock) {
                    failedBlock(jsonDict);
                }
            }else{
                if ([arrData isEqual:[NSNull new]]) {
                    return ;
                }
                if ([arrData isKindOfClass:[NSString class]]) {
                    arrData = @[arrData];
                }
                if (successBlock) {
                    successBlock(arrData);
                }
            }
        }else{
            if (failedBlock) {
                failedBlock(nil);
            }
        }
    }];
    [dataTask resume];
}

- (void)loadGetDataWithUrl:(NSString *)urlStr andSuccessBlock:(void (^)(NSArray *))successBlock andFiledBlock:(void (^)(NSError *))failedBlock{
  
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arrData = [jsonDict objectForKey:@"data"];
            NSLog(@"--:%@",arrData);
            if ([arrData isEqual:[NSNull new]]) {
                if (successBlock) {
                    successBlock(arrData);
                }
                return ;
            }
            if (arrData == nil || arrData.count < 1) {
                
            }else{
                
            }
            if (successBlock) {
                successBlock(arrData);
            }
            
        }else{
            if (failedBlock) {
                failedBlock(error);
            }
        }
    }];
    [dataTask resume];
}

@end
