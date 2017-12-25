//
//  QuitAlertView.m
//  好梦学车
//
//  Created by haomeng on 2017/4/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "QuitAlertView.h"

#define ShowBoxViewWidth 315
#define ShowBoxViewHeight 135

#define ShowBoxViewWidthTwo 315
#define ShowBoxViewHeightTwo 165

#define WRation [UIScreen mainScreen].bounds.size.width/375
#define HRation [UIScreen mainScreen].bounds.size.height/667

@implementation QuitAlertView{
    UIView *_subBoxView;
    QuitBoxView *showView;
}

+ (instancetype)createShowView{
    NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"QuitAlertView" owner:nil options:nil];
    if (xibs.count > 0) {
        return xibs.firstObject;
    }
    return nil;
}

- (void)dismissSync{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

- (void)presentAddView:(UIView *)view withType:(QuitBoxViewType)type{
    [view.window addSubview:self];
    CGFloat w = 0;
    CGFloat H = 0;
    if (type == QuitBoxViewTypeCancelAndSure) {
        w = ShowBoxViewWidth*WRation;
       H = ShowBoxViewHeight*HRation;
    }else{
        w = ShowBoxViewWidthTwo*WRation;
        H = ShowBoxViewHeightTwo*HRation;
    }
    
    NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"QuitBoxView" owner:nil options:nil];
    
    showView = xibs.firstObject;
    showView.frame = CGRectMake(self.center.x-w/2, self.center.y - H/2, 0, 0);
    showView.center = CGPointMake(self.center.x, self.center.y);
    showView.type = type;
    showView.delegate = self;
    showView.layer.cornerRadius = 3;
    showView.layer.masksToBounds = YES;
    [self addSubview:showView];
   
   
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        showView.frame = CGRectMake(self.center.x-w/2, self.center.y - H/2, w, H);
        
    } completion:^(BOOL finished) {
        showView.showLabel.hidden = NO;
    }];
}

- (void)setDescribeStr:(NSString *)describeStr{
    showView.showLabel.text = describeStr;
}

- (void)setLetfTitle:(NSString *)letfTitle{
    [showView.LookBtn setTitle:letfTitle forState:UIControlStateNormal];
}

- (void)setRightTitle:(NSString *)rightTitle{
    [showView.LeaveBtn setTitle:rightTitle forState:UIControlStateNormal];
}

- (void)setSureTitle:(NSString *)sureTitle{
    [showView.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
}

#pragma mark - QuitBoxViewDelegate
- (void)QuitBoxViewBtnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(btnClickedWithBtn:)]) {
        [self.delegate performSelector:@selector(btnClickedWithBtn:) withObject:btn];
    }
    if (btn.tag == 1001) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
//                showView.frame = CGRectMake(self.center.x, self.center.y, 0, 0);
//                
//                showView.showLabel.hidden = YES;
//                showView.LookBtn.hidden = YES;
//                showView.LeaveBtn.hidden = YES;
                
            } completion:^(BOOL finished) {
                [showView removeFromSuperview];
                [self dismissSync];
            }];
        });
       
    }else{
        [self dismissSync];
    }
    
}


@end
