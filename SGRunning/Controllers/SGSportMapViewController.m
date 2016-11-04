//
//  SGSportMapViewController.m
//  SGRunning
//
//  Created by 孙冠 on 16/11/4.
//  Copyright © 2016年 sunguan. All rights reserved.
//

#import "SGSportMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "SGSportTrackingLine.h"

@interface SGSportMapViewController ()<MAMapViewDelegate>

@end

@implementation SGSportMapViewController{
    /// 起始位置
    CLLocation *_startLocation;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupMapView];
}

///添加地图视图
- (void)setupMapView {
    
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:mapView];
    
    mapView.showsScale = NO;
    
    mapView.rotateCameraEnabled = NO;
    
    mapView.showsUserLocation = YES;
    
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    mapView.allowsBackgroundLocationUpdates = YES;
    
    mapView.pausesLocationUpdatesAutomatically = NO;
    
    mapView.delegate = self;
}

#pragma mark - MAMapView代理方法
/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    // 0. 判断 `位置数据` 是否变化 - 不一定是经纬度变化！
    if (!updatingLocation) {
        return;
    }
    
    // 1. 判断运动状态，只有`继续`才需要绘制运动轨迹
    if (_sportTracking.sportState != SGSportStateContinue) {
        return;
    }
    
    // 大概 1s 更新一次！
    // NSLog(@"%@ %p", userLocation.location, userLocation.location);
    
    // 判断起始位置是否存在
    if (_startLocation == nil) {
        _startLocation = userLocation.location;
        
        // 1. 实例化大头针
        MAPointAnnotation *annotaion = [MAPointAnnotation new];
        
        // 2. 指定坐标位置
        annotaion.coordinate = userLocation.location.coordinate;
        
        // 3. 添加到地图视图
        [mapView addAnnotation:annotaion];
    }
    
    // 绘制轨迹模型
    [mapView addOverlay:[_sportTracking appendLocation:userLocation.location]];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    // 1. 查询可重用大头针视图
    static NSString *annotaionId = @"annotaionId";
    MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotaionId];
    
    // 2. 如果没有查到，新建视图
    if (annotationView == nil) {
        annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotaionId];
    }
    
    // 3. 设置大头针视图 - 设置图像
    // 根据运动类型来创建运动图像
    UIImage *image = _sportTracking.sportImage;
    annotationView.image = image;
    annotationView.centerOffset = CGPointMake(0, -image.size.height * 0.5);
    
    // 4. 返回自定义大头针视图
    return annotationView;
}

// 需要实现MAMapViewDelegate的-mapView:rendererForOverlay:
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    
    // 1. 判断 overlay 的类型
    if (![overlay isKindOfClass:[MAPolyline class]]) {
        return nil;
    }
    
    // 2. 实例化折线渲染器
    SGPolyLine *polyline = (SGPolyLine *)overlay;
    MAPolylineRenderer *renderer = [[MAPolylineRenderer alloc] initWithPolyline:polyline];
    
    // 3. 设置显示属性
    renderer.lineWidth = 5;
    renderer.strokeColor = polyline.color;
    
    return renderer;
}

@end
