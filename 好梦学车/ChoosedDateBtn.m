//
//  ChoosedDateBtn.m
//  好梦学车
//
//  Created by haomeng on 2017/12/7.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoosedDateBtn.h"

@implementation ChoosedDateBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.titleLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
}

@end
