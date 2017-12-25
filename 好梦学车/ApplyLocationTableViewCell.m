//
//  ApplyLocationTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ApplyLocationTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ApplyLocationTableViewCell

# pragma mark - 创建tableViewCell的类方法
+ (id)cellWithTableToDequeueReusable:(UITableView *)table
                          identifier:(NSString *)identifier
                             nibName:(NSString *)nibName
{
    if (table) {
        id reused = [table dequeueReusableCellWithIdentifier:identifier];
        if (reused) return reused;
    }
    UITableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
    return cell;
}

- (void)setModel:(OffLineServerStation *)model{
    _model = model;
    
    if (model.imageUrl) {
        [_logoImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"pic02"]];
    }else{
        [_logoImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"pic02"]];
    }
    
    _firstLabel.text = [NSString stringWithFormat:@"%@",model.name];
    _secondLabel.text = [NSString stringWithFormat:@"地址:%@",model.address];
//    _Third.text = [NSString stringWithFormat:@"电话:%@",model.phone];
}
- (IBAction)clickActive:(id)sender {
    if (_block) {
        _block(_model);
    }
}

- (void)blockActiveWithBlock:(void (^)(OffLineServerStation *))block{
    _block = block;
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
