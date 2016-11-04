//
//  SGPolyLine.h
//  SGRunning
//
//  Created by 孙冠 on 16/11/4.
//  Copyright © 2016年 sunguan. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
//自定义折线模型，增加颜色属性
@interface SGPolyLine : MAPolyline

//构造方法
+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color;

//折线颜色
@property (nonatomic, strong) UIColor *color;

@end
