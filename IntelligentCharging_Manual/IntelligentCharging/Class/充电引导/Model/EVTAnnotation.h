//
//  EVTAnnotation.h
//  IntelligentCharging
//
//  Created by 陈吉 on 16/3/6.
//  Copyright © 2016年 YF-IOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"


@interface EVTAnnotation : NSObject<BMKAnnotation>

//坐标
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
//两个title
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

//自定义图片
@property (nonatomic, strong) UIImage *image;

@end
