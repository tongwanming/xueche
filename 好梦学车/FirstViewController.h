//
//  FirstViewController.h
//  haomengxueche
//
//  Created by haomeng on 2017/4/18.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"

@protocol FirstViewControllerDelegate <NSObject>

- (void)FirstViewControllerDelegateWithActiveVC:(BasicViewController *)v andTag:(NSString *)tag;
@end

@interface FirstViewController : BasicViewController

@property (nonatomic, assign)id<FirstViewControllerDelegate>delegate;

@end
