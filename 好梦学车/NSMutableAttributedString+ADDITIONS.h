//
//  NSMutableAttributedString+ADDITIONS.h
//  好梦学车
//
//  Created by haomeng on 2017/12/4.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (ADDITIONS)

+ (NSMutableAttributedString *)textKitAboutWithStr:(NSString *)firstStr andImage:(UIImage *)image andOtherStr:(NSString *)otherStr andBound:(CGRect)bound;

+ (NSMutableAttributedString *)textKitAboutWithImage:(UIImage *)imagea andWithStr:(NSString *)firstStr andImage:(UIImage *)image andOtherStr:(NSString *)otherStr andBound:(CGRect)bound;

@end
