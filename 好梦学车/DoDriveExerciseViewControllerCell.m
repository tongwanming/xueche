//
//  DoDriveExerciseViewControllerCell.m
//  好梦学车
//
//  Created by haomeng on 2017/12/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "DoDriveExerciseViewControllerCell.h"

@implementation DoDriveExerciseViewControllerCell

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

- (void)setModel:(DoDriveExerciseModel *)model{
    _model = model;
    
    _currentType.text = model.currentType;
    _timeLabel.text = model.time;
    _locationLabel.text = model.location;
    _cocoaNameLabel.text = model.cocoaName;
    
    [_stateLabel setTitle:model.stateName forState:UIControlStateNormal];
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
