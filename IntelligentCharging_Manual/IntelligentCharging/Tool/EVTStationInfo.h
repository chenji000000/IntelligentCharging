//
//  EVTStationInfo.h
//  IntelligentCharging
//
//  Created by YF-IOS on 16/3/4.
//  Copyright © 2016年 YF-IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVTStationInfo : NSObject

@property (nonatomic, assign)int id;
@property (nonatomic, strong)NSString *stationName;
@property (nonatomic, strong)NSString *stationAddress;
@property (nonatomic, strong)NSString *longitude;
@property (nonatomic, strong)NSString *latitude;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *workday;
@property (nonatomic, strong)NSString *holiday;
@property (nonatomic, strong)NSString *stationImage;
@property (nonatomic, assign)int chargingPiles;
@property (nonatomic, strong)NSString *companyName;
@property (nonatomic, strong)NSString *electronicFence;
@property (nonatomic, assign)int waitingPeople;
@property (nonatomic, assign)int rapidChargings;
@property (nonatomic, assign)int rapidChargingsFree;
@property (nonatomic, assign)int rapidChargingsOccupied;
@property (nonatomic, assign)int rapidChargingsPrice;
@property (nonatomic, assign)int rapidChargingsUnavailable;
@property (nonatomic, assign)int rapidChargingsUnknown;
@property (nonatomic, assign)int slowChargings;
@property (nonatomic, assign)int slowChargingsFree;
@property (nonatomic, assign)int slowChargingsOccupied;
@property (nonatomic, assign)int slowChargingsPrice;
@property (nonatomic, assign)int slowChargingsUnavailable;
@property (nonatomic, assign)int slowChargingsUnknown;

+(id)stationInfoWithJSON:(NSDictionary *)jsonDic;

@end
