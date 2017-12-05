//
//  createTableViewCellFactoryTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/12/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "createNormalCellModel.h"

@interface createTableViewCellFactoryTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andModel:(createNormalCellModel *)model;

@end
