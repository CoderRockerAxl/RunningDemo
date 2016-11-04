//
//  SGSportTracking.h
//  SGRunning
//
//  Created by 孙冠 on 16/11/4.
//  Copyright © 2016年 sunguan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGSportTrackingLine.h"
///运动类型枚举
typedef enum : NSUInteger {
    SGSportTypeRun,
    SGSportTypeWalk,
    SGSportTypeBike,
} SGSportType;

///运动状态枚举
typedef enum : NSUInteger {
    SGSportStateContinue,
    SGSportStatePause,
    SGSportStateFinish,
} SGSportState;

@interface SGSportTracking : NSObject

//使用运动类型和运动状态实例化追踪模型
- (instancetype)initWithType:(SGSportType)type state:(SGSportState)state;

///运动类型
@property (nonatomic, assign, readonly) SGSportType sportType;

//运动状态
@property (nonatomic, assign) SGSportState sportState;

//运动图像
@property (nonatomic, strong, readonly) UIImage *sportImage;

//追加当前位置，返回折线模型
- (SGPolyLine *)appendLocation:(CLLocation *)location;

//平均速度
@property (nonatomic, readonly) double avgSpeed;

//最大速度
@property (nonatomic, readonly) double maxSpeed;

//总时长
@property (nonatomic, readonly) double totalTime;

//总距离
@property (nonatomic, readonly) double totalDistance;

@end
