//
//  TestSiteChoosedViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import "TestSiteChoosedModel.h"

typedef void(^TestSiteChoosedViewControllerBlock)(TestSiteChoosedModel *);

@interface TestSiteChoosedViewController : BasicViewController

@property (nonatomic, strong) NSString *kskm;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, copy)TestSiteChoosedViewControllerBlock block;

- (void)TestSiteChoosedViewControllerActive:(void(^)(TestSiteChoosedModel *model))block;

@end
