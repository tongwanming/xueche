//
//  TestSiteChoosedTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "TestSiteChoosedTableViewCell.h"

@implementation TestSiteChoosedTableViewCell

# pragma mark - 创建tableViewCell的类方法
+ (id)cellWithTableToDequeueReusable:(UITableView *)table
                          identifier:(NSString *)identifier
                             nibName:(NSString *)nibName
{
    if (table) {
        id reused = [table dequeueReusableCellWithIdentifier:identifier];
        if (reused) return reused;
    }
    UITableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
