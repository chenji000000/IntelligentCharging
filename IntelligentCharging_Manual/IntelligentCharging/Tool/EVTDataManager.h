//
//  EVTDataManager.h
//  IntelligentCharging
//
//  Created by YF-IOS on 16/3/4.
//  Copyright © 2016年 YF-IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVTDataManager : NSObject

//给定数组（字典）类型，返回一个已经解析好的数组（模型对象）
+(NSArray *)stationInfo:(NSDictionary *)stationInfoDic;

@end
