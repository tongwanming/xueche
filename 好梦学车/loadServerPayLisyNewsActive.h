//
//  loadServerPayLisyNewsActive.h
//  好梦学车
//
//  Created by haomeng on 2017/11/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicViewController.h"
#import "PersonIndentModel.h"
#import <UIKit/UIKit.h>

@interface loadServerPayLisyNewsActive : NSObject

+ (loadServerPayLisyNewsActive *)defalutManager;

-(void)loadSecuritiesWithVC:(BasicViewController *)vc;

-(void)loadSecuWithVC:(BasicViewController *)vc withBlokc:(void(^)(PersonIndentModel *modle))block;

@end
