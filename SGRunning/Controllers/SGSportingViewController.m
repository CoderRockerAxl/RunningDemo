//
//  SGSportingViewController.m
//  SGRunning
//
//  Created by 孙冠 on 16/11/4.
//  Copyright © 2016年 sunguan. All rights reserved.
//

#import "SGSportingViewController.h"
#import "SGSportMapViewController.h"
@interface SGSportingViewController ()
/**
 运动地图控制器
 */
@property (nonatomic, weak) SGSportMapViewController *mapViewController;

@end

@implementation SGSportingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupMapView];
}

- (IBAction)chengeSportState:(UIButton *)sender {
    // 修改地图控制器的运动状态
    _mapViewController.sportTracking.sportState = sender.tag;
}

- (void)setupMapView {
    // 1. 获取地图控制器
    for (UIViewController *child in self.childViewControllers) {
        if ([child isKindOfClass:[SGSportMapViewController class]]) {
            _mapViewController = (SGSportMapViewController *)child;
            
            break;
        }
    }
    
    // 2. 设置运动轨迹模型
    _mapViewController.sportTracking = [[SGSportTracking alloc] initWithType:_sportType state:SGSportStateContinue];
}

@end
