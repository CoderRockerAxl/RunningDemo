//
//  SGSportTrackingLine.m
//  SGRunning
//
//  Created by 孙冠 on 16/11/4.
//  Copyright © 2016年 sunguan. All rights reserved.
//

#import "SGSportTrackingLine.h"

@implementation SGSportTrackingLine

- (instancetype)initWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation {
    self = [super init];
    if (self) {
        _startLocation = startLocation;
        _endLocation = endLocation;
    }
    return self;
}

- (SGPolyLine *)polyline {
    
    CLLocationCoordinate2D coords[2];
    
    coords[0] = _startLocation.coordinate;
    coords[1] = _endLocation.coordinate;
    
    //按速度改变颜色
    CGFloat factor = 8;
    CGFloat red = factor * self.speed / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:1 blue:0 alpha:1];
    
    // 测试两点间的运动数据
    NSLog(@"速度 %f 时间 %f 距离 %f", self.speed, self.time, self.distance);
    
    return [SGPolyLine polylineWithCoordinates:coords count:2 color:color];
}

- (double)speed {
    return (_startLocation.speed + _endLocation.speed) * 0.5 * 3.6;
}

- (NSTimeInterval)time {
    return [_endLocation.timestamp timeIntervalSinceDate:_startLocation.timestamp];
}

- (double)distance {
    return [_endLocation distanceFromLocation:_startLocation] * 0.001;
}
@end
