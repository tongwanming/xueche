//
//  MKAnnotationView+MapAnnotation.h
//  好梦学车
//
//  Created by haomeng on 2017/12/8.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKAnnotationView (MapAnnotation)

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;

@end
