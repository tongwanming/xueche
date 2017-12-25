//
//  QuitBoxView.h
//  好梦学车
//
//  Created by haomeng on 2017/4/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,QuitBoxViewType) {
    QuitBoxViewTypeCancelOnly,
    QuitBoxViewTypeCancelAndSure
};

@protocol QuitBoxViewDelegate <NSObject>

- (void)QuitBoxViewBtnClick:(UIButton *)btn;

@end

@interface QuitBoxView : UIView
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIButton *LookBtn;
@property (weak, nonatomic) IBOutlet UIButton *LeaveBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic, assign)QuitBoxViewType type;
@property (nonatomic, weak) id<QuitBoxViewDelegate>delegate;

@end
