//
//  EVTDataManager.m
//  IntelligentCharging
//
//  Created by YF-IOS on 16/3/4.
//  Copyright © 2016年 YF-IOS. All rights reserved.
//

#import "EVTDataManager.h"
#import "EVTStationInfo.h"

@implementation EVTDataManager

+(NSArray *)stationInfo:(NSDictionary *)stationInfoDic
{
    NSArray *stationInfoArray = stationInfoDic[@"data"];
    NSMutableArray *stationInfoMutableArray = [NSMutableArray array];
    for (NSDictionary *stationInfoDictionary in stationInfoArray) {
        EVTStationInfo *stationInfo = [EVTStationInfo stationInfoWithJSON:stationInfoDictionary];
        [stationInfoMutableArray addObject:stationInfo];
    }
    return [stationInfoMutableArray copy];
}

@end
