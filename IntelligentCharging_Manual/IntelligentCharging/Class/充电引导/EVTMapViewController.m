//
//  EVTMapViewController.m
//  IntelligentCharging
//
//  Created by YF-IOS on 16/3/4.
//  Copyright © 2016年 YF-IOS. All rights reserved.
//

#import "EVTMapViewController.h"
#import "BMapKit.h"
#import "HudHelper.h"
#import "EVTAnnotation.h"
#import "EVTHTTPHelper.h"
#import "EVTStationInfo.h"
#import "EVTDataManager.h"

/**屏幕的宽度*/
#define K_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/**屏幕的高度*/
#define K_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface EVTMapViewController ()<BMKMapViewDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
//管理类(征求用户定位同意)
@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation EVTMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
    
    self.view = self.mapView;
    
    //征求用户同意(iOS8+/假定用户iOS8+/Info.plist)
    self.manager = [CLLocationManager new];
    //假定用户同意定位
    [self.manager requestWhenInUseAuthorization];
    
    //设置代理
    self.mapView.delegate=self;
    
    //初始化地图位置（武汉）
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(30.563702, 114.298973) animated:YES];
    
    
    self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
    
    [self loadData];
}

-(void)loadData
{
    
    
    [EVTHTTPHelper getStationInfoWithSuccess:^(NSDictionary *jsonResult) {
        EVTStationInfo *stationInfo = [EVTStationInfo stationInfoWithJSON:jsonResult];
        NSArray *stationInfoArray = [EVTDataManager stationInfo:jsonResult];
        //判断服务器返回的数据不为空
        if (stationInfoArray.count == 0) {
            return;
        }
        //需求：获取所有站点信息的经纬度（添加大头针对象到地图上）
        for (EVTStationInfo *stationInfo in stationInfoArray) {
            NSLog(@"latitude:%@, longitude:%@", stationInfo.latitude, stationInfo.longitude);
            EVTAnnotation *annotation=[EVTAnnotation new];
            annotation.coordinate = CLLocationCoordinate2DMake([stationInfo.latitude doubleValue], [stationInfo.longitude doubleValue]);
            
            //避免在同一个站点多次添加大头针对象
            //重写isEqual方法（同一个站点的大头针对象的地址不一样）
            if ([self.mapView.annotations containsObject:annotation]) {
                //不要添加（继续下次循环）
                continue;
            }
            
            [self.mapView addAnnotation:annotation];
            
        }
    } failure:^(NSString *errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidAppear:(BOOL)animated {
   

    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 30.563702;
    coor.longitude = 114.298973;
    annotation.coordinate = coor;
    annotation.title = @"这里是武汉";
    [self.mapView addAnnotation:annotation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    //把蓝色圈排除
    if ([annotation isKindOfClass:[BMKUserLocation class]]) {
        return nil;
    }
    //写重用机制
    static NSString *identifier=@"annotation";
    BMKAnnotationView *annotationView=[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        annotationView=[[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        //显示弹出框
        annotationView.canShowCallout=YES;
    }
    EVTAnnotation *anno=(EVTAnnotation *)annotation;
    annotationView.image=[UIImage imageNamed:@"ic_annotation_destination_online"];
    annotationView.annotation=annotation;
    
    return annotationView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
