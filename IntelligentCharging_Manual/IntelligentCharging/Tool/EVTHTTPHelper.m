//
//  EVTHTTPHelper.m
//  IntelligentCharging
//
//  Created by YF-IOS on 16/3/3.
//  Copyright © 2016年 YF-IOS. All rights reserved.
//

#import "EVTHTTPHelper.h"

static NSString *const kWebService = @"http://111.175.187.206:5007/ChargePipeService";

@implementation EVTHTTPHelper

//检查网络是否连接
+(BOOL) isNetworkConnected{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

+ (AFHTTPSessionManager *)sharedAFManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    });
    return manager;
}

//发起HTTP请求，返回值为JSON（NSDictionary）
+ (void) HTTPWithUrl:(NSString *) url
               post:(NSDictionary *)post
            success:(void (^)(NSDictionary * jsonResult))success
            failure:(void (^)(NSString * errorMessage))failure {
    if ([EVTHTTPHelper isNetworkConnected] == NO) {
        if (failure) {
            failure(@"请打开网络连接");
        }
        return;
    }
    [[EVTHTTPHelper sharedAFManager] POST:url parameters:post success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功
//        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure: %@",error);
        NSString * errorMessage;
        if (error.code == -1001) {
            errorMessage = @"请求超时";
        } else if(error.code == -1004) {
            errorMessage = @"网络不通";
        } else {
            errorMessage = [NSString stringWithFormat:@"连接失败[%ld]",(long)error.code];
        }
        if (failure) {
            failure(errorMessage);
        }
    }];
    
}

////发起HTTP请求，返回值为NSString
//+(void) HTTPWithUrl:(NSString *) url
//               post:(NSDictionary *)post
//  successWithString:(void (^)(NSString * result))success
//            failure:(void (^)(NSString * errorMessage))failure{
//    if ([EVTHTTPHelper isNetworkConnected] == NO){
//        if (failure) {
//            failure(@"请打开网络连接");
//        }
//        return;
//    }
//    [[EVTHTTPHelper sharedAFManager] POST:url parameters:post success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        success(responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"failure: %@",error);
//        NSString * errorMessage;
//        if (error.code == -1001) {
//            errorMessage = @"请求超时";
//        } else if(error.code == -1004) {
//            errorMessage = @"网络不通";
//        } else {
//            errorMessage = [NSString stringWithFormat:@"连接失败[%ld]",(long)error.code];
//        }
//        if (failure) {
//            failure(errorMessage);
//        }
//    }];
//}

//生成流水号
+(void) generationSerialNumberWithPaymentType:(NSString *)paymentType
                                memberAccount:(NSString *)memberAccount
                                     memberID:(NSString *)memberID
                                    loginName:(NSString *)loginName
                                       txnAmt:(NSString *)txnAmt
                                      success:(void (^)(NSDictionary * jsonResult))success
                                      failure:(void (^)(NSString * errorMessage))failure{

}

//通过充电站ID或者充电桩ID获取充电桩信息
+(void) getPipeInfoWithStationId:(int)stationId
                          pipeId:(int)pipeId
                         success:(void (^)(NSDictionary * jsonResult))success
                         failure:(void (^)(NSString * errorMessage))failure{

}

//获取充电站信息
+(void) getStationInfoWithSuccess:(void (^)(NSDictionary * jsonResult))success
                          failure:(void (^)(NSString * errorMessage))failure{
    NSString *url = [kWebService stringByAppendingString:@"/Ws/stationResource/getStationInfo"];
   
    [EVTHTTPHelper HTTPWithUrl:url post:nil success:^(NSDictionary *jsonResult){
        if (success) {
            success(jsonResult);
        }
    } failure:^(NSString *errorMessage) {
        if (failure) {
            failure(errorMessage);
        }
    }];

}

//根据电桩快慢、适配车型以及电桩是否空闲得到充电站
+(void) getStationByWASWithChargeWay:(NSString *)chargeWay
                     vehicleTypeName:(NSString *)vehicleTypeName
                              status:(NSString *)status
                          fuzzyParam:(NSString *)fuzzyParam
                             success:(void (^)(NSDictionary * jsonResult))success
                             failure:(void (^)(NSString * errorMessage))failure{
}

//获取适配车型信息
+(void) getVehicleTypeInfoWithPipeNo:(NSString *)pipeNo
                             success:(void (^)(NSDictionary * jsonResult))success
                             failure:(void (^)(NSString * errorMessage))failure{
}

//充电桩加盟
+(void) stationLeagueWithStationName:(NSString *)stationName
                      stationAddress:(NSString *)stationAddress
                           longitude:(NSString *)longitude
                            latitude:(NSString *)latitude
                               phone:(NSString *)phone
                             workday:(NSString *)workday
                             holiday:(NSString *)holiday
                        stationImage:(NSString *)stationImage
                         companyName:(NSString *)companyName
                     electronicFence:(NSString *)electronicFence
                 rapidChargingsPrice:(NSString *)rapidChargingsPrice
                  slowChargingsPrice:(NSString *)slowChargingsPrice
                     chargePipeInfos:(NSString *)chargePipeInfos
                              pipeNo:(NSString *)pipeNo
                              typeId:(NSString *)typeId
                            systemNo:(NSString *)systemNo
                             success:(void (^)(NSDictionary * jsonResult))success
                             failure:(void (^)(NSString * errorMessage))failure{
}

//通过给定的坐标获取充电站
+(void) getStationByCoordinateWithCoordinate:(NSString *)coordinate
                                     success:(void (^)(NSDictionary * jsonResult))success
                                     failure:(void (^)(NSString * errorMessage))failure{
}

//添加充电站信息
+(void) addStationInfoWithStationName:(NSString *)stationName
                       stationAddress:(NSString *)stationAddress
                            longitude:(NSString *)longitude
                             latitude:(NSString *)latitude
                                phone:(NSString *)phone
                              workday:(NSString *)workday
                              holiday:(NSString *)holiday
                         stationImage:(NSString *)stationImage
                          companyName:(NSString *)companyName
                      electronicFence:(NSString *)electronicFence
                  rapidChargingsPrice:(NSString *)rapidChargingsPrice
                   slowChargingsPrice:(NSString *)slowChargingsPrice
                              success:(void (^)(NSDictionary * jsonResult))success
                              failure:(void (^)(NSString * errorMessage))failure{
}

//添加充电桩类型信息
+(void) saveOrUpdatePipeTypeInfoWithId:(int)id
                              typeName:(NSString *)typeName
                          standardName:(NSString *)standardName
                          facturerName:(NSString *)facturerName
                             modelName:(NSString *)modelName
                         chargeWayName:(NSString *)chargeWayName
                       currentTypeName:(NSString *)currentTypeName
                          tatedCurrent:(NSString *)tatedCurrent
                          tatedVoltage:(NSString *)tatedVoltage
                            tatedPower:(NSString *)tatedPower
                               success:(void (^)(NSDictionary * jsonResult))success
                               failure:(void (^)(NSString * errorMessage))failure{
}

//获取充电桩类型信息
+(void) getPipeTypeInfoWithId:(int)id
                      success:(void (^)(NSDictionary * jsonResult))success
                      failure:(void (^)(NSString * errorMessage))failure{
}

//修改或更新充电桩信息
+(void) saveOrUpdatePipeInfoWithId:(NSString *)id
                            pipeNo:(NSString *)pipeNo
                         stationId:(NSString *)stationId
                        pipeTypeId:(NSString *)pipeTypeId
                          systemNo:(NSString *)systemNo
                           success:(void (^)(NSDictionary * jsonResult))success
                           failure:(void (^)(NSString * errorMessage))failure{
}

//删除充电桩信息
+(void) deletePipeInfoByIdWithId:(NSString *)id
                         success:(void (^)(NSDictionary * jsonResult))success
                         failure:(void (^)(NSString * errorMessage))failure{
}

//通过登录名获取充电站信息
+(void) getStationInfoByLoginNameWithLoginName:(NSString *)loginName
                                       success:(void (^)(NSDictionary * jsonResult))success
                                       failure:(void (^)(NSString * errorMessage))failure{

}

//获取标准名称
+(void) getInterfaceStandardInfoWithSuccess:(void (^)(NSDictionary * jsonResult))success
                                    failure:(void (^)(NSString * errorMessage))failure{
}

//获取充电桩生产厂商名称
+(void) getManufacturerInfoWithSuccess:(void (^)(NSDictionary * jsonResult))success
                               failure:(void (^)(NSString * errorMessage))failure{

}

//获取型号名称
+(void) getPipeModelInfoWithSuccess:(void (^)(NSDictionary * jsonResult))success
                            failure:(void (^)(NSString * errorMessage))failure{

}

//删除充电桩类型信息
+(void) deletePipeTypeInfoWithId:(int)id
                         success:(void (^)(NSDictionary * jsonResult))success
                         failure:(void (^)(NSString * errorMessage))failure{

}

//会员信息注册
+(void) insertMemberInfoWithLoginName:(NSString *)loginName
                             passWord:(NSString *)passWord
                             trueName:(NSString *)trueName
                                  sex:(int)sex
                                email:(NSString *)email
                              levelID:(int)levelID
                               status:(int)status
                            telephone:(NSString *)telephone
                              success:(void (^)(NSDictionary * jsonResult))success
                              failure:(void (^)(NSString * errorMessage))failure{

}
//会员登录
+(void) memberLoginWithLoginName:(NSString *)loginName
                        passWord:(NSString *)passWord
                         success:(void (^)(NSDictionary * jsonResult))success
                         failure:(void (^)(NSString * errorMessage))failure{
//    NSString *url = [kWebService stringByAppendingString:@"memberLogin"];
//    NSDictionary *post = @{@"loginName" : loginName,
//                           @"passWord" : passWord};
//    [EVTHTTPHelper HTTPWithUrl:url post:post success:^(NSDictionary *jsonResult){
//        if (success) {
//            success(jsonResult);
//        }
//    } failure:^(NSString *errorMessage) {
//        if (failure) {
//            failure(errorMessage);
//        }
//    }];
    

}

//获取当前充电桩最后预约时间和当前已预约人数
+(void) getLatestAdvanceInfoWithPipeId:(int)pipeId
                               success:(void (^)(NSDictionary * jsonResult))success
                               failure:(void (^)(NSString * errorMessage))failure{

}

//添加充电桩预约记录
+(void) insertAdvanceRecordWithPipeId:(int)pipeId
                             memberId:(int)memberId
                     advanceTimeStart:(NSString *)advanceTimeStart
                       advanceTimeEnd:(NSString *)advanceTimeEnd
                              success:(void (^)(NSDictionary * jsonResult))success
                              failure:(void (^)(NSString * errorMessage))failure{

}

//更新充电桩预约记录状态
+(void) updateAdvanceRecordWithId:(int)id
                    advanceStatus:(int)advanceStatus
                          success:(void (^)(NSDictionary * jsonResult))success
                          failure:(void (^)(NSString * errorMessage))failure{

}

//查询充电桩预约历史记录
+(void) getAdvanceRecordWithMemberId:(int)memberId
                    advanceTimeStart:(NSString *)advanceTimeStart
                      advanceTimeEnd:(NSString *)advanceTimeEnd
                             success:(void (^)(NSDictionary * jsonResult))success
                             failure:(void (^)(NSString * errorMessage))failure{

}


@end
