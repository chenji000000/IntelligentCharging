//
//  EVTStationInfo.m
//  IntelligentCharging
//
//  Created by YF-IOS on 16/3/4.
//  Copyright © 2016年 YF-IOS. All rights reserved.
//

#import "EVTStationInfo.h"

@implementation EVTStationInfo

+(id)stationInfoWithJSON:(NSDictionary *)jsonDic
{
    return [[self alloc] initWithJSON:jsonDic];
}

-(id)initWithJSON:(NSDictionary *)jsonDic{
    if (self=[super init]) {
        //经纬度
        self.latitude = jsonDic[@"latitude"];
        self.longitude = jsonDic[@"longitude"];
        
    }
    return self;

}



@end
