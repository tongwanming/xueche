//
//  NSMutableAttributedString+ADDITIONS.m
//  好梦学车
//
//  Created by haomeng on 2017/12/4.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "NSMutableAttributedString+ADDITIONS.h"


@implementation NSMutableAttributedString (ADDITIONS)

+ (NSMutableAttributedString *)textKitAboutWithStr:(NSString *)firstStr andImage:(UIImage *)image andOtherStr:(NSString *)otherStr andBound:(CGRect)bound{
    if (firstStr == nil) {
        firstStr = @"";
    }
    
    if (otherStr == nil) {
        otherStr = @"";
    }
    
    NSMutableAttributedString *mutAttributedStr = [[NSMutableAttributedString alloc] initWithString:firstStr attributes:nil];
    
    if (image) {
        NSTextAttachment *attachement = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        attachement.image = image;
        attachement.bounds = bound;
        NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attachement];
        [mutAttributedStr appendAttributedString:attributedString];
    }
    
    if (otherStr.length > 0) {
        NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:otherStr attributes:nil];
        [mutAttributedStr appendAttributedString:attributedStr];
    }
    
    
    return mutAttributedStr;
}

+(NSMutableAttributedString *)textKitAboutWithImage:(UIImage *)imagea andWithStr:(NSString *)firstStr andImage:(UIImage *)image andOtherStr:(NSString *)otherStr andBound:(CGRect)bound{
    
    
    if (firstStr == nil) {
        firstStr = @"";
    }
    
    if (otherStr == nil) {
        otherStr = @"";
    }
    
    NSMutableAttributedString *mutAttributedStr = [[NSMutableAttributedString alloc] initWithString:@"" attributes:nil];
    
    if (imagea) {
        NSTextAttachment *attachement = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        attachement.image = imagea;
        attachement.bounds = bound;
        NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attachement];
        [mutAttributedStr appendAttributedString:attributedString];
    }
    NSMutableAttributedString *attributedStra = [[NSMutableAttributedString alloc] initWithString:firstStr attributes:nil];
    [mutAttributedStr appendAttributedString:attributedStra];
    
    
    if (image) {
        NSTextAttachment *attachementa = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        attachementa.image = image;
        attachementa.bounds = bound;
        NSAttributedString *attributedStringa = [NSAttributedString attributedStringWithAttachment:attachementa];
        [mutAttributedStr appendAttributedString:attributedStringa];
    }
    
    
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:otherStr attributes:nil];
    [mutAttributedStr appendAttributedString:attributedStr];
    
    return mutAttributedStr;
}

@end
