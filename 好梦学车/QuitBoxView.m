//
//  QuitBoxView.m
//  好梦学车
//
//  Created by haomeng on 2017/4/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "QuitBoxView.h"

@implementation QuitBoxView

- (void)setType:(QuitBoxViewType)type{
    if (type == QuitBoxViewTypeCancelOnly) {
        _LookBtn.hidden =  YES;
        _LeaveBtn.hidden = YES;
        _sureBtn.hidden = NO;
        _lineView.hidden = NO;
    }else{
        _LookBtn.hidden =  NO;
        _LeaveBtn.hidden = NO;
        _sureBtn.hidden = YES;
        _lineView.hidden = YES;
    }
}

- (IBAction)btnClickActive:(id)sender {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self removeFromSuperview];
//    });
    if ([self.delegate respondsToSelector:@selector(QuitBoxViewBtnClick:)]) {
        [self.delegate performSelector:@selector(QuitBoxViewBtnClick:) withObject:(UIButton *)sender];
    }
}


@end
