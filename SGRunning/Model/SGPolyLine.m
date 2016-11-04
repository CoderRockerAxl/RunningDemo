//
//  SGPolyLine.m
//  SGRunning
//
//  Created by 孙冠 on 16/11/4.
//  Copyright © 2016年 sunguan. All rights reserved.
//

#import "SGPolyLine.h"

@implementation SGPolyLine

+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color {
    
    SGPolyLine *polyline = [self polylineWithCoordinates:coords count:count];
    
    polyline.color = color;
    
    return polyline;
}

@end
