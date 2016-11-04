//
//  SGSportTrackingLine.h
//  SGRunning
//
//  Created by 孙冠 on 16/11/4.
//  Copyright © 2016年 sunguan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import "SGPolyLine.h"

@interface SGSportTrackingLine : NSObject

///通过起点终点实例化追踪模型
- (instancetype)initWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation;

//起点
@property (nonatomic, strong, readonly) CLLocation *startLocation;

//停止点
@property (nonatomic, strong, readonly) CLLocation *endLocation;

//划线模型
@property (nonatomic, readonly) SGPolyLine *polyline;

/**
 起始点和结束点之间的平均速度，单位是 `公里/小时`
 如果使用 CLLocationSpeed 可能会产生误解
 */
@property (nonatomic, readonly) double speed;

//时间
@property (nonatomic, readonly) NSTimeInterval time;

//距离
@property (nonatomic, readonly) double distance;

@end
