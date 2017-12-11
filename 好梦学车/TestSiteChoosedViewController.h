//
//  TestSiteChoosedViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"

typedef void(^TestSiteChoosedViewControllerBlock)(int n);

@interface TestSiteChoosedViewController : BasicViewController

@property (nonatomic, copy)TestSiteChoosedViewControllerBlock block;

- (void)TestSiteChoosedViewControllerActive:(TestSiteChoosedViewControllerBlock)block;

@end
