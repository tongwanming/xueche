//
//  choosedCarTypeViewTap.h
//  好梦学车
//
//  Created by haomeng on 2017/10/24.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface choosedCarTypeViewTap : UIView

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) NSString *title1;

@property (nonatomic, strong) NSString *title2;

- (instancetype)initWithFrame:(CGRect)frame andTitleOne:(NSString *)title1 andTitleTwo:(NSString *)title2;

@end
