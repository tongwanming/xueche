//
//  TestMapTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/12/8.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestMapTableViewCell : UITableViewCell
+ (id)cellWithTableToDequeueReusable:(UITableView *)table
                          identifier:(NSString *)identifier
                             nibName:(NSString *)nibName;

@property (nonatomic, strong) NSArray *data;
@end
