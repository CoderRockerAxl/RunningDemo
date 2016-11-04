//
//  SGSportTracking.m
//  SGRunning
//
//  Created by 孙冠 on 16/11/4.
//  Copyright © 2016年 sunguan. All rights reserved.
//

#import "SGSportTracking.h"

@implementation SGSportTracking {
/// 起始点位置
CLLocation *_startLocation;
/// 所有运动线条模型的数组
NSMutableArray <SGSportTrackingLine *>*_trackingLines;
}

- (instancetype)initWithType:(SGSportType)type state:(SGSportState)state {
    self = [super init];
    if (self) {
        _sportType = type;
        _sportState = state;
        
        _trackingLines = [NSMutableArray array];
    }
    return self;
}

#pragma mark - 设置数据
- (void)setSportState:(SGSportState)sportState {
    _sportState = sportState;
    
    // 判断状态类型，如果不是继续，需要清空起始点
    if (_sportState != SGSportStateContinue) {
        _startLocation = nil;
    }
}

#pragma mark - 计算型属性&公共方法
- (UIImage *)sportImage {
    
    UIImage *image;
    switch (_sportType) {
        case SGSportTypeRun:
            image = [UIImage imageNamed:@"map_annotation_run"];
            break;
        case SGSportTypeWalk:
            image = [UIImage imageNamed:@"map_annotation_walk"];
            break;
        case SGSportTypeBike:
            image = [UIImage imageNamed:@"map_annotation_bike"];
            break;
    }
    
    return image;
}

- (SGPolyLine *)appendLocation:(CLLocation *)location {
    
    // 0. 判断速度是否发生变化 - 性能优化，室内定位，速度有可能为`负数`
    if (location.speed <= 0) {
        return nil;
    }
    
    // 判断定位的时间差值，暂时定义一个时间差值因子 - 性能优化（避免室内出现杂线）
    CGFloat factor = 2;
    if ([[NSDate date] timeIntervalSinceDate:location.timestamp] > factor) {
        // 如果超过时间差值，就认为定位的精度不够
        return nil;
    }
    
    // 1. 判断是否存在起始点
    if (_startLocation == nil) {
        
        _startLocation = location;
        
        return nil;
    }
    
    // 2. 创建追踪线条模型
    SGSportTrackingLine *trackingLine = [[SGSportTrackingLine alloc] initWithStartLocation:_startLocation endLocation:location];
    
    [_trackingLines addObject:trackingLine];
    
    // 测试`总`时长 - `KVC` - sum 能够计算数组中的汇总数据，返回类型是 NSNumber
    //NSLog(@"%@ %@", [_trackingLines valueForKeyPath:@"@sum.time"], [[_trackingLines valueForKeyPath:@"@sum.time"] class]);
    NSLog(@"%f - %f - %f - %f", self.avgSpeed, self.maxSpeed, self.totalTime, self.totalDistance);
    
    // 3. 将当前位置设置成下一次的起始点
    _startLocation = location;
    
    // 4. 返回折线模型
    return trackingLine.polyline;
}

- (double)avgSpeed {
    return [[_trackingLines valueForKeyPath:@"@avg.speed"] doubleValue];
}

- (double)maxSpeed {
    return [[_trackingLines valueForKeyPath:@"@max.speed"] doubleValue];
}

- (double)totalTime {
    return [[_trackingLines valueForKeyPath:@"@sum.time"] doubleValue];
}

- (double)totalDistance {
    return [[_trackingLines valueForKeyPath:@"@sum.distance"] doubleValue];
}
@end
