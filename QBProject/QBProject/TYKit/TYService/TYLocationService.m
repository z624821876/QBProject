//
//  TYLocationService.m
//  MPProject
//
//  Created by QuincyYan on 16/5/27.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYLocationService.h"
#import <CoreLocation/CoreLocation.h>

@interface TYLocationService() <CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *manager;
@property (nonatomic,copy) serviceSearchedBlock block;
@end

@implementation TYLocationService

- (instancetype)init{
    if (self!=[super init]) {
        return nil;
    }
    _manager = [[CLLocationManager alloc] init];
    return self;
}

- (void)startServiceWithBlock:(serviceSearchedBlock)block{
    NSString *alwaysKey = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined || status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        if (alwaysKey) {
            [_manager requestAlwaysAuthorization];
        } else {
            [_manager requestWhenInUseAuthorization];
        }
        _block = block;
        _manager.delegate = self;
        [_manager startMonitoringSignificantLocationChanges];
        [_manager startUpdatingLocation];
    } else {
        NSLog(@"用户选择不支持定位");
    }
}

- (void)verifyUserLocationState {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined || status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
    } else {
        [TYPopover showPopoverWithTitle:@"定位失败"
                            detailsText:@"请前去开启定位功能以便更好地为您服务"
                      cancelButtonTitle:@"取消"
                           otherButtons:@[@"前去开启"] completeHandler:^(NSInteger index) {
                               if (index == 0) {
                                   [NSObject openWithURL:UIApplicationOpenSettingsURLString];
                               }
                           }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"heading:%@",newHeading);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    __weak typeof(self) wself = self;
    [geocoder reverseGeocodeLocation:[locations firstObject] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            if (placemarks && placemarks.count > 0) {
                CLPlacemark *placeMark = [placemarks firstObject];
                if (wself.block && placeMark.locality && placeMark.locality.length > 0) {
                    wself.block(placeMark.locality);
                    NSLog(@"placemarks:%@",placeMark.addressDictionary);
                    wself.block = nil;
                    wself.manager.delegate = nil;
                    [wself.manager stopUpdatingLocation];
                    [wself.manager stopMonitoringSignificantLocationChanges];
                }
            }else{
                NSLog(@"placemarks为空");
            }
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error:%@",error);
}

@end
