//
//  createTableViewHander.h
//  好梦学车
//
//  Created by haomeng on 2017/12/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "createNormalCellModel.h"

@interface createTableViewHander : NSObject

+ (UITableViewCell *)createTableViewWithModel:(createNormalCellModel *)model;

@end
