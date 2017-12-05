//
//  createTableViewHander.m
//  好梦学车
//
//  Created by haomeng on 2017/12/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "createTableViewHander.h"
#import "createTableViewCellFactoryTableViewCell.h"

@implementation createTableViewHander
+ (UITableViewCell *)createTableViewWithModel:(createNormalCellModel *)model{
    UITableViewCell *cell = [[createTableViewCellFactoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"" andModel:model];

    return cell;

}
@end
