//
//  BBTaskDetailViewController.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBTaskDetailViewController.h"
#import <MapKit/MapKit.h>
#import "OPAnnotaion.h"
#import "BBWeatherRequest.h"
#import "BBWeatherObject.h"

@interface OPAnnotaionView : MKAnnotationView

@property (nonatomic, strong) UILabel *addressLabel;

- (void)setAddress:(NSString *)address;

@end

@implementation OPAnnotaionView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 240.0, 200.0)];
        [self addSubview:_addressLabel];
        self.frame = CGRectMake(0.0, 0.0, 240.0, 200.0);
    }
    return self;
}

- (void)setAddress:(NSString *)address
{
    self.addressLabel.text = address;
}

@end


@interface BBTaskDetailViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong)CLLocationManager *manager;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) BBAirportObject *airport;


@property (weak, nonatomic) IBOutlet UILabel *airportCode;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *cloudHeight;

@property (weak, nonatomic) IBOutlet UILabel *cloudType;
@property (weak, nonatomic) IBOutlet UILabel *visibility;

@property (weak, nonatomic) IBOutlet UILabel *weather;
@property (weak, nonatomic) IBOutlet UILabel *windDirection;
@property (weak, nonatomic) IBOutlet UILabel *windSpeed;
@property (weak, nonatomic) IBOutlet UILabel *summary;

@end

@implementation BBTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.manager = [[CLLocationManager alloc] init];
    if ([_manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_manager requestWhenInUseAuthorization];
    }
    [self refreshUI];
}
- (IBAction)changeAirport:(UISegmentedControl *)sender {
    [self refreshUI];
}

- (void)prepareDataSource {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.airport = self.task.departure;
    }else {
        self.airport = self.task.arrival;
    }
}

- (void)requestForWeather {
    [self showProgressHud];
    BBWeatherRequest *request = [BBWeatherRequest request];
    request.path = [request.path stringByAppendingPathComponent:self.airport.ID];
    [request sendRequest:^(id data, NSError *error) {
        [self dismissProgressHud];
        if (error) {
            [self showErrorInHudWithError:error];
        }else {
            [self refreshWeather:data];
        }
    }];
}

- (void)refreshWeather:(BBWeatherObject *)weather {
    self.airportCode.text = [NSString stringWithFormat:@"airportCode : %@", [self notNil:weather.airportCode]];
    self.cloudHeight.text = [NSString stringWithFormat:@"cloudHeight : %@", [self notNil:weather.cloudHeight]];
    self.cloudType.text = [NSString stringWithFormat:@"cloudType : %@", [self notNil:weather.cloudType]];
    self.time.text = [NSString stringWithFormat:@"time : %@", [self notNil:weather.time]];
    self.visibility.text = [NSString stringWithFormat:@"visibility : %@", [self notNil:weather.visibility]];
    self.weather.text = [NSString stringWithFormat:@"weather : %@", [self notNil:weather.weather]];
    self.windDirection.text = [NSString stringWithFormat:@"windDirection : %@", [self notNil:weather.windDirection]];
    self.windSpeed.text = [NSString stringWithFormat:@"windSpeed : %@", [self notNil:weather.windSpeed]];

}

- (NSString *)notNil:(NSString *)str {
    if (str.length == 0) {
        return @"N/A";
    }
    return str;
}

- (void)reloadUI {
    [self requestForWeather];
    self.summary.text = [NSString stringWithFormat:@"Airport:%@    ID:%@", self.airport.airportName, self.airport.ID];
    if (nil == self.airport.longitude || nil == self.airport.latitude) {
        self.airport.latitude = @"39.983763";
        self.airport.longitude = @"116.313265";
    }
    
//    self.airport.latitude = @"39.983763";
//    self.airport.longitude = @"116.313265";
    
    CLLocationDegrees longitude =[self.airport.longitude doubleValue];
    CLLocationDegrees latitude =[self.airport.latitude doubleValue];
    
    OPAnnotaion *anno1 = [[OPAnnotaion alloc] init];
    anno1.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    anno1.title = self.airport.airportName;
//    anno1.subtitle = self.room.schoolAreaName;
    
    [self.mapView addAnnotation:anno1];
    /* 显示中心 */
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(latitude, longitude);
    //    /* 显示范围 */
    CGFloat zoomLevel = 0.23;
    MKCoordinateSpan span = MKCoordinateSpanMake(zoomLevel, zoomLevel);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    /* 设置地图显示区域 */
    [self.mapView setRegion:region animated:YES];
    [self.mapView selectAnnotation:anno1 animated:YES];
}

/**
 *  添加大头针时会调用这个方法
 *  @param annotation 添加的大头针模型
 *
 *  @return 大头针View
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    /* 判断如果是显示用户位置的大头针就返回nil */
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    
    /* 自定义的大头针模型对象,返回MKPinAnnotationView */
    static NSString *ID = @"annoView";
    MKPinAnnotationView *annoView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annoView == nil) {
        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
        /* 设置显示标题和子标题 */
        annoView.canShowCallout = YES;
        /* 设置大头针颜色 */
        annoView.pinColor = MKPinAnnotationColorPurple;
        /* 设置掉落效果 */
        annoView.animatesDrop = YES;
    }
    annoView.annotation = annotation;
    return annoView;
}
/**
 *  当获取用户的位置信息时,会调用该方法
 *
 *  @param userLocation 大头针模型(用户描述一个大头针信息)
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"%f - %f", mapView.region.center.latitude,mapView.region.center.longitude);
    NSLog(@"--%f--%f", mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
