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
    createNormalCellStyleUserDdfinedFifth,//文字为多行，切宽度是屏幕的3/5宽
    createNormalCellStyleUserDdfinedSix,//错题和立即练题部分
    createNormalCellStyleUserDdfinedSeven,//底部，需要传入文字颜色和背景颜色和文字颜色
    createNormalCellStyleUserDdfinedEight,//悬空的错题和立即练题部分
    createNormalCellStyleUserDdfinedTen,//场地第一个
    createNormalCellStyleUserDdfinedEleven,//场地第二个
    createNormalCellStyleUserDdfinedThreeth,//场地第三个
    
//------------------------------------------------------
    createNormalCellStyleNormal,//文字剧中，需要传入文字颜色大小,只有文字
    createNormalCellStyleNormal1,//普通tableView。只需要传入颜色和文字大小，可以添加go按钮
    createNormalCellStyleValue1,
    createNormalCellStyleValue2,
    createNormalCellStyleSubtitle,
    createNormalCellStyleBang,//显示考试成绩，需要传入分数
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
@property (nonatomic, strong) UIColor *bgColor;


@property (nonatomic, strong) NSString *detailTitle;
@property (nonatomic, strong) NSString *otherDetailTitle;
@property (nonatomic, strong) NSString *goImageStr;
@property (nonatomic, assign) float imHe;

@property (nonatomic, strong) NSString *imageViewStr;
@property (nonatomic, assign) UIViewContentMode contenModel;//显示图片的位置
@property (nonatomic, assign) BOOL hasFootViewLine;//是否有一横线 yes 没有。默认有
@property (nonatomic, assign) BOOL hasDefalut;//默认为0 为0 的时候有两个显示区，为1的时候只有中间一个按钮

@property (nonatomic, assign) float orginalX;

@property (nonatomic, assign) float he;//当前的高度

@property (nonatomic, assign) float grade;//考试成绩



@end
