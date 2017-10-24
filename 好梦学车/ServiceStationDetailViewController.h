//
//  ServiceStationDetailViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/10/13.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import "OffLineServerStation.h"

@interface ServiceStationDetailViewController : BasicViewController

@property (nonatomic, strong)OffLineServerStation *model;


@property (nonatomic, strong) NSString *address;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *bigTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *metroLine;
@property (weak, nonatomic) IBOutlet UILabel *busStationNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *allBusLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
