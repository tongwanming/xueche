//
//  ChoosedClassTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/10/24.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoosedClassTableViewCell.h"

@implementation ChoosedClassTableViewCell{
    UILabel *_titleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    
    return self;
}

- (void)setStr:(NSString *)str{
    
    NSArray *arr = [self arrAddWidthStr:str];
    [self showUIWidthData:arr];
    NSLog(@"%@",arr);
}

- (NSArray *)arrAddWidthStr:(NSString *)str{
    
    NSMutableString *mutStr = [NSMutableString stringWithString:str];
    
    NSArray *mutArr = [mutStr componentsSeparatedByString:@"#"];
    
    NSArray *arr = [NSArray arrayWithArray:mutArr];
    
    return arr;
}

- (NSArray *)arrAddWidthStrOther:(NSString *)str{
    
    NSMutableString *mutStr = [NSMutableString stringWithString:str];
    
    NSArray *mutArr = [mutStr componentsSeparatedByString:@"@"];
    
    NSArray *arr = [NSArray arrayWithArray:mutArr];
    
    return arr;
}

- (void)showUIWidthData:(NSArray *)arr{
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    float _heightLast = 0.0;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, CURRENT_BOUNDS.width-40, 16)];
    _titleLabel.font = [UIFont systemFontOfSize:16*TYPERATION];
    _titleLabel.text = @"费用明细";
    _titleLabel.textColor = UNMAIN_TEXT_COLOR;
    [self.contentView addSubview:_titleLabel];
    
    for (int i = 0; i<arr.count; i++) {
        float _currentHeight = 0;
        if (_heightLast == 0.0) {
            _currentHeight = CGRectGetMaxY(_titleLabel.frame)+20;
        }else{
            _currentHeight = 0.0;
        }
        NSArray *subArr = [self arrAddWidthStrOther:arr[i]];
        UIView *layerView = [[UIView alloc] initWithFrame:CGRectMake(20, _currentHeight+_heightLast, 7*TYPERATION, 7*TYPERATION)];
        layerView.layer.masksToBounds = YES;
        layerView.layer.cornerRadius = 3.5*TYPERATION;
        layerView.backgroundColor = TEXT_COLOR;
        [self.contentView addSubview:layerView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(layerView.frame)+16, _currentHeight+_heightLast, CURRENT_BOUNDS.width-16, 15*TYPERATION)];
        label.textColor = TEXT_COLOR;
        label.text = [NSString stringWithFormat:@"%@:",subArr[0]];
        label.font = [UIFont systemFontOfSize:15*TYPERATION];
        [self.contentView addSubview:label];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(layerView.frame)+16, CGRectGetMaxY(label.frame)+5, CURRENT_BOUNDS.width-16-20-17*TYPERATION, 15*TYPERATION+28)];
        label1.textColor = UNMAIN_TEXT_COLOR;
        label1.text = subArr[1];
        label1.numberOfLines = 0;
//        label1.backgroundColor = [UIColor redColor];
        label1.font = [UIFont systemFontOfSize:15*TYPERATION];
        label1.frame = CGRectMake(CGRectGetMaxX(layerView.frame)+16, CGRectGetMaxY(label.frame)+5, CURRENT_BOUNDS.width-16-20-17*TYPERATION, [self heightForString:label1.text andWidth:label1.frame.size.width amdFont:15*TYPERATION]);
        [self.contentView addSubview:label1];
        _heightLast = CGRectGetMaxY(label1.frame)+10;
    }
}

- (float)heightForString:(NSString *)titleString andWidth:(float)width amdFont:(float)font{
    CGSize titleSize = [titleString boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    return titleSize.height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
