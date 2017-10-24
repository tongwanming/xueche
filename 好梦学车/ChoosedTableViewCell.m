//
//  ChoosedTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/10/24.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoosedTableViewCell.h"

@implementation ChoosedTableViewCell{
    UILabel *_titleLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
    }
    
    return self;
}

- (void)setData:(NSArray *)data{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, CURRENT_BOUNDS.width-40, 16)];
    _titleLabel.font = [UIFont systemFontOfSize:16*TYPERATION];
    _titleLabel.text = @"服务内容";
    _titleLabel.textColor = UNMAIN_TEXT_COLOR;
    [self.contentView addSubview:_titleLabel];
    
    for (int i = 0; i<data.count; i++) {
        
        UIView *layerView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_titleLabel.frame)+25+4+(15+14)*i, 7*TYPERATION, 7*TYPERATION)];
        layerView.layer.masksToBounds = YES;
        layerView.layer.cornerRadius = 3.5*TYPERATION;
        layerView.backgroundColor = TEXT_COLOR;
        [self.contentView addSubview:layerView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(layerView.frame)+16, CGRectGetMaxY(_titleLabel.frame)+25+(15+14)*i, CURRENT_BOUNDS.width-16, 15*TYPERATION)];
        label.textColor = UNMAIN_TEXT_COLOR;
        label.text = data[i];
        label.font = [UIFont systemFontOfSize:15*TYPERATION];
        [self.contentView addSubview:label];
    }
}

- (void)setStr:(NSString *)str{
    
    self.data = [self arrAddWidthStr:str];
}

- (NSArray *)arrAddWidthStr:(NSString *)str{
    
    NSMutableString *mutStr = [NSMutableString stringWithString:str];
    
    NSMutableArray *mutArr = [mutStr componentsSeparatedByString:@"#"];
    
    NSArray *arr = [NSArray arrayWithArray:mutArr];
    
    return arr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
