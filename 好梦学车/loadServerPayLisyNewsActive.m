//
//  loadServerPayLisyNewsActive.m
//  好梦学车
//
//  Created by haomeng on 2017/11/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "loadServerPayLisyNewsActive.h"
#import "NSDictionary+objectForKeyWitnNoNsnull.h"
#import "OrderValidityManager.h"

#import "CustomAlertView.h"

@implementation loadServerPayLisyNewsActive
 static loadServerPayLisyNewsActive *_manager;

+ (loadServerPayLisyNewsActive *)defalutManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[loadServerPayLisyNewsActive alloc] init];
        }
    });
    return _manager;
    
}

-(void)loadSecuritiesWithVC:(BasicViewController *)vc{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *userid = [userDic objectForKey:@"userId"];
    
    NSDictionary *dic =@{@"userId":userid};
    
    
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
    
    
    //    NSURL *url = [NSURL URLWithString:urlstr];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:7071/api/order/query/queryOrderList",PUBLIC_LOCATION]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    [CustomAlertView showAlertViewWithVC:vc];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *success = [NSString stringWithFormat:@"%@",[jsonDict objectForKey:@"success"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [CustomAlertView hideAlertView];
            });
            if (success.boolValue) {
                NSArray *arr = [jsonDict objectForKey:@"data"];
                NSDictionary *dic = arr[0];
                
                NSDictionary *imageDic = @{@"1001":@"http://or3qk800m.bkt.clouddn.com/101@2x.png",@"1002":@"http://or3qk800m.bkt.clouddn.com/201@2x.png",@"1003":@"http://or3qk800m.bkt.clouddn.com/301@2x.png",@"1004":@"http://or3qk800m.bkt.clouddn.com/501@2x.png"};
                
                PersonIndentModel *model = [[PersonIndentModel alloc] init];
                if ([[dic objectForKeyWithNoNsnull:@"projectTypeName"] isEqualToString:@"C2"]) {
                    model.name = [NSString stringWithFormat:@"%@自动挡",[dic objectForKeyWithNoNsnull:@"projectTypeName"]];
                }else{
                    model.name = [NSString stringWithFormat:@"%@手动挡",[dic objectForKeyWithNoNsnull:@"projectTypeName"]];
                }
                model.type = [dic objectForKeyWithNoNsnull:@"productName"];
                model.price = [self changeTypeWithStr:[dic objectForKeyWithNoNsnull:@"price"]];
                model.origialPrice = [self changeTypeWithStr:[dic objectForKeyWithNoNsnull:@"originalPrice"]];
                model.isUseCoupon = [self changeTypeWithStr:[dic objectForKeyWithNoNsnull:@"isUseCoupon"]];
                model.couponPrice = [self changeTypeWithStr:[dic objectForKeyWithNoNsnull:@"couponPrice"]];
                model.indentNum = [dic objectForKeyWithNoNsnull:@"orderNo"];
                model.data = @[[dic objectForKeyWithNoNsnull:@"buyerName"],[dic objectForKeyWithNoNsnull:@"trainplaceName"],model.type,[dic objectForKeyWithNoNsnull:@"coachName"]];
                model.createTimeStr = [dic objectForKeyWithNoNsnull:@"createTime"];
                if ([imageDic objectForKey:@"categoryCode"]) {
                    model.urlName = [imageDic objectForKey:@"categoryCode"];
                }else{
                    model.urlName = @"http://or3qk800m.bkt.clouddn.com/501@2x.png";
                }
                model.indentStatus = [dic objectForKeyWithNoNsnull:@"status"];
                model.payTime = [dic objectForKeyWithNoNsnull:@"payTime"];
                if ([[dic objectForKeyWithNoNsnull:@"status"] isEqualToString:@"FINISH"]) {
                    model.bigTitle = @"订单已完成";
                }else{
                    model.bigTitle = @"等待付款中...";
                }
                //               model.desribeStr = @"120";
                
                [[OrderValidityManager defaultManager] setModelWithData:model];
                
                NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
                [formatter1 setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
                
                NSDate *resDate = [formatter1 dateFromString:[dic objectForKeyWithNoNsnull:@"createTime"]];
                NSMutableDictionary *mutDic = [[NSMutableDictionary alloc] init];
                [mutDic setObject:resDate forKey:@"date"];
                [[NSUserDefaults standardUserDefaults] setObject:mutDic forKey:@"date"];
                
                
                NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                if (!userDic) {
                    userDic = [[NSMutableDictionary alloc] init];
                }
                [userDic setObject:[dic objectForKey:@"orderNo"] forKey:@"payNum"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"payType"] forKey:@"choosedPayType"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"productName"] forKey:@"myClass"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"trainplaceName"] forKey:@"myPlace"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"coachName"] forKey:@"myConsult"];
                [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"personNews"];
                
            }else{
                //登录失败
                
            }
        }else{
            
        }
    }];
    [dataTask resume];
    
}

- (NSString *)changeTypeWithStr:(NSString *)str{
    int n = [str intValue];
    int newN = n/100;
    
    NSString *newStr = [NSString stringWithFormat:@"%d",newN];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:newStr];
    [mutStr insertString:@"," atIndex:1];
    
    NSString *resultStr = [NSString stringWithString:mutStr];
    
    return resultStr;
    
}


-(void)loadSecuWithVC:(BasicViewController *)vc withBlokc:(void(^)(PersonIndentModel *modle))block{
    
    
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *userid = [userDic objectForKey:@"userId"];
    
    NSDictionary *dic =@{@"userId":userid};
    
    
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
    
    PersonIndentModel *model = [[PersonIndentModel alloc] init];
    //    NSURL *url = [NSURL URLWithString:urlstr];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:7071/api/order/query/queryOrderList",PUBLIC_LOCATION]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
//    [CustomAlertView showAlertViewWithVC:vc];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *success = [NSString stringWithFormat:@"%@",[jsonDict objectForKey:@"success"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                
//                [CustomAlertView hideAlertView];
            });
            if (success.boolValue) {
                NSArray *arr = [jsonDict objectForKey:@"data"];
                NSDictionary *dic = arr[0];
                
                NSDictionary *imageDic = @{@"1001":@"http://or3qk800m.bkt.clouddn.com/101@2x.png",@"1002":@"http://or3qk800m.bkt.clouddn.com/201@2x.png",@"1003":@"http://or3qk800m.bkt.clouddn.com/301@2x.png",@"1004":@"http://or3qk800m.bkt.clouddn.com/501@2x.png"};
                
                
                if ([[dic objectForKeyWithNoNsnull:@"projectTypeName"] isEqualToString:@"C2"]) {
                    model.name = [NSString stringWithFormat:@"%@自动挡",[dic objectForKeyWithNoNsnull:@"projectTypeName"]];
                }else{
                    model.name = [NSString stringWithFormat:@"%@手动挡",[dic objectForKeyWithNoNsnull:@"projectTypeName"]];
                }
                model.type = [dic objectForKeyWithNoNsnull:@"productName"];
                model.price = [self changeTypeWithStr:[dic objectForKeyWithNoNsnull:@"price"]];
                model.origialPrice = [self changeTypeWithStr:[dic objectForKeyWithNoNsnull:@"originalPrice"]];
                model.isUseCoupon = [dic objectForKeyWithNoNsnull:@"isUseCoupon"];
                model.couponPrice = [self changeTypeWithStr:[dic objectForKeyWithNoNsnull:@"couponPrice"]];
                model.indentNum = [dic objectForKeyWithNoNsnull:@"orderNo"];
                model.data = @[[dic objectForKeyWithNoNsnull:@"buyerName"],[dic objectForKeyWithNoNsnull:@"trainplaceName"],model.type,[dic objectForKeyWithNoNsnull:@"coachName"]];
                model.createTimeStr = [dic objectForKeyWithNoNsnull:@"createTime"];
                if ([dic objectForKey:@"categoryCode"]) {
                    model.urlName = [imageDic objectForKey:[dic objectForKey:@"categoryCode"]];
                }else{
                    model.urlName = @"http://or3qk800m.bkt.clouddn.com/501@2x.png";
                }
                model.indentStatus = [dic objectForKeyWithNoNsnull:@"status"];
                model.payTime = [dic objectForKeyWithNoNsnull:@"payTime"];
                if ([[dic objectForKeyWithNoNsnull:@"status"] isEqualToString:@"FINISH"]) {
                    model.bigTitle = @"订单已完成";
                }else{
                    model.bigTitle = @"等待付款中...";
                }
                //               model.desribeStr = @"120";
                if (block) {
                    block(model);
                }
                [[OrderValidityManager defaultManager] setModelWithData:model];
                
                NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
                [formatter1 setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
                
                NSDate *resDate = [formatter1 dateFromString:[dic objectForKeyWithNoNsnull:@"createTime"]];
                NSMutableDictionary *mutDic = [[NSMutableDictionary alloc] init];
                [mutDic setObject:resDate forKey:@"date"];
                [[NSUserDefaults standardUserDefaults] setObject:mutDic forKey:@"date"];
                
                
                NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                if (!userDic) {
                    userDic = [[NSMutableDictionary alloc] init];
                }
                [userDic setObject:[dic objectForKey:@"orderNo"] forKey:@"payNum"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"payType"] forKey:@"choosedPayType"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"productName"] forKey:@"myClass"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"trainplaceName"] forKey:@"myPlace"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"coachName"] forKey:@"myConsult"];
                [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"personNews"];
                
            }else{
                //登录失败if (block) {
                if (block) {
                    block(nil);
                }
            }
        }else{
            
        }
    }];
    [dataTask resume];
    
}

@end
