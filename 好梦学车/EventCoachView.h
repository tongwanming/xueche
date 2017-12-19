//
//  EventCoachView.h
//  好梦学车
//
//  Created by haomeng on 2017/8/23.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstLocationModel.h"


@interface EventCoachView : UIView

+ (EventCoachView *)shareDefault;

- (void)showEventCoachViewWithVC:(UIViewController *)vc andWithName:(NSString *)coachName andImage:(NSString *)image andBlock:(void(^)(NSString *_des,NSString *_point))block;

- (void)showEventCoachViewWithVC:(UIViewController *)vc andModel:(FirstLocationModel *)model andBlock:(void(^)(UIButton *btn))block;

- (void)dismissView;

@end
