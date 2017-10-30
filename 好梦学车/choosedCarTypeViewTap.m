//
//  choosedCarTypeViewTap.m
//  好梦学车
//
//  Created by haomeng on 2017/10/24.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "choosedCarTypeViewTap.h"

@implementation choosedCarTypeViewTap{
    UIView *_backGroundView;
    UILabel *_priceLabel;
    UILabel *_typeLabel;
}

- (instancetype)initWithFrame:(CGRect)frame andTitleOne:(NSString *)title1 andTitleTwo:(NSString *)title2{
    if (self = [super initWithFrame:frame]) {
        
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _backGroundView.backgroundColor = ECEFF4;
        _backGroundView.layer.masksToBounds = YES;
        _backGroundView.layer.cornerRadius = 8;
        [self addSubview:_backGroundView];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 17.25*TYPERATION, frame.size.width, 20*TYPERATION)];
        _priceLabel.textColor = TEXT_COLOR;
        _priceLabel.text = [NSString stringWithFormat:@"¥%@",title1];
        _priceLabel.font = [UIFont systemFontOfSize:20*TYPERATION];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_priceLabel];
        
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_priceLabel.frame)+13, frame.size.width, 25/2*TYPERATION)];
        _typeLabel.textColor = ADB1B9;
        _typeLabel.text = [NSString stringWithFormat:@"%@",title2];
        _typeLabel.font = [UIFont systemFontOfSize:25/2*TYPERATION];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_typeLabel];
        
    }
    
    return self;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (isSelected) {
        _backGroundView.backgroundColor = E5F5FF;
        _backGroundView.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
        _backGroundView.layer.borderWidth = 1;
        _priceLabel.textColor = BLUE_BACKGROUND_COLOR;
        _typeLabel.textColor = BLUE_BACKGROUND_COLOR;
    }else{
        _backGroundView.backgroundColor = ECEFF4;
        _backGroundView.layer.borderColor = ECEFF4.CGColor;
        _backGroundView.layer.borderWidth = 1;
        _priceLabel.textColor = TEXT_COLOR;
        _typeLabel.textColor = UNMAIN_TEXT_COLOR;
    }
}

- (void)setTitle1:(NSString *)title1{
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",title1];
}

- (void)setTitle2:(NSString *)title2{
    _typeLabel.text = [NSString stringWithFormat:@"%@",title2];
}

@end
