//
//  createNormalCellModel.h
//  好梦学车
//
//  Created by haomeng on 2017/12/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, createNormalCellStyle) {
    //此处为自定的cell
    createNormalCellStyleUserDdfinedOne,//学习时长和累积学习时间
    createNormalCellStyleUserDdfinedTwo,//确认按钮
    createNormalCellStyleUserDdfinedThere,//上部分的部分，可带水印或者不带水印
    createNormalCellStyleUserDdfinedForth,//白色背景，文字，需要传入文字内容，大小，颜色
    createNormalCellStyleUserDdfinedFifth,
    
    
//------------------------------------------------------
    createNormalCellStyleNormal,//文字剧中，需要传入文字颜色大小,只有文字
    createNormalCellStyleNormal1,//普通tableView。只需要传入颜色和文字大小，可以添加go按钮
    createNormalCellStyleValue1,
    createNormalCellStyleValue2,
    createNormalCellStyleSubtitle,
    createNormalCellStyleOnlyImageCenter,//一个cell 上就一个image，默认中间，自适应
    createNormalCellStyleOnlyImageNormal   //一个cell 上就一个image，可以定义image的位置，默认在最左边
};

@interface createNormalCellModel : NSObject

@property (nonatomic, strong) NSMutableAttributedString *AttributedStr;

@property (nonatomic, strong) NSString *learnTime;
@property (nonatomic, strong) NSString *learnedTime;

@property (nonatomic, assign) createNormalCellStyle style;//cell 种类
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) float titleFont;
@property (nonatomic, strong) UIColor *color;


@property (nonatomic, strong) NSString *detailTitle;
@property (nonatomic, strong) NSString *otherDetailTitle;
@property (nonatomic, strong) NSString *goImageStr;
@property (nonatomic, assign) float imHe;

@property (nonatomic, strong) NSString *imageViewStr;
@property (nonatomic, assign) UIViewContentMode contenModel;//显示图片的位置
@property (nonatomic, assign) BOOL hasFootViewLine;

@property (nonatomic, assign) float orginalX;

@property (nonatomic, assign) float he;



@end
