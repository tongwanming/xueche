//
//  ChoosedSecuritiesViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/11/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import "SecuritiesModel.h"

typedef void(^choosedSecuritiesBlock)(SecuritiesModel *model);

@interface ChoosedSecuritiesViewController : BasicViewController

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy) choosedSecuritiesBlock securitiesBlock;

- (void)returnChoosedSecuritiesBlock:(choosedSecuritiesBlock)block;


@end
