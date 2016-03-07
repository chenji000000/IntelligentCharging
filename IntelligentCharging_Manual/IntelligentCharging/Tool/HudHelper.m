//
//  HudHelper.m
//  IntelligentCharging
//
//  Created by YF-IOS on 16/2/29.
//  Copyright © 2016年 YF-IOS. All rights reserved.
//

#import "HudHelper.h"

@implementation HudHelper

+(void) showHudWithMessage:(NSString *) message toView:(UIView *)view{
    //首先隐藏之前的Hud
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [UIFont systemFontOfSize:17];
    hud.margin = 30.f;
    hud.removeFromSuperViewOnHide = YES;
    //hud.dimBackground = YES;
    //hud.square = YES;
    [hud hide:YES afterDelay:1.2];
}
//显示带有旋转图案的HUD，需要通过调用hideHudForView来隐藏HUD
+(void) showProgressHudWithMessage:(NSString *) message toView:(UIView *)view{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:view];
    [view addSubview:hud];
    //延时0.1秒显示
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = message;
        hud.labelFont = [UIFont systemFontOfSize:17];
        hud.margin = 20.f;
        hud.removeFromSuperViewOnHide = YES;
        //hud.dimBackground = YES;
        hud.square = YES;
        [hud show:YES];
    });
}
//隐藏Hud
+(void) hideHudToView:(UIView *)view{
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
}


@end
