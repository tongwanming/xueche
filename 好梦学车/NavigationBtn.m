//
//  NavigationBtn.m
//  好梦学车
//
//  Created by haomeng on 2017/10/23.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "NavigationBtn.h"

@implementation NavigationBtn
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textColor = UNMAIN_TEXT_COLOR;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake((self.frame.size.width-30)/2, 30, 30, 30);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), self.frame.size.width, 26);
    
}

@end
