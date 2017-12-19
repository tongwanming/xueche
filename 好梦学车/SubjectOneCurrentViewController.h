//
//  SubjectOneCurrentViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/12/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import <MapKit/MapKit.h>

@protocol SubjectOneCurrentViewControllerDelegate <NSObject>

- (void)SubjectOneCurrentViewControllerDelegateWithActiveVC:(BasicViewController *)v andTag:(NSString *)tag;
@end

@interface SubjectOneCurrentViewController : BasicViewController

@property (nonatomic, strong) NSArray *locationData;

@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;

@property (nonatomic, weak)id<SubjectOneCurrentViewControllerDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *progressImageView;

@end
