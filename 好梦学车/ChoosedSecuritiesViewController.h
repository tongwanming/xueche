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



@property (nonatomic, copy) choosedSecuritiesBlock securitiesBlock;

- (void)returnChoosedSecuritiesBlock:(choosedSecuritiesBlock)block;

@property (nonatomic, strong) NSString *categoryCode;

@property (nonatomic, strong) NSString *price;


@end
