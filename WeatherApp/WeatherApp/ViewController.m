//
//  ViewController.m
//  WeatherApp
//
//  Created by Thuong on 7/15/16.
//  Copyright © 2016 Thuong. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "Weather.h"
#import "OWMWeatherAPI.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
@interface ViewController ()
@property NSMutableArray *weathers;
@property OWMWeatherAPI *weatherAPI;
@property CLLocationCoordinate2D locationCoordinate2D;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer ];
    self.revealViewController.delegate = self;

    UIImage *image = [UIImage imageNamed:@"bg.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    _weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"b16b2e7aff85eb1bb2ae43df25bf4b2d"];
    [_weatherAPI setTemperatureFormat:kOWMTempCelcius];
    [self findCurrentLocation];
    
    
    Weather *currentWeather;
    currentWeather = [[Weather alloc] init];
    [_weatherAPI currentWeatherByCoordinate:_locationCoordinate2D withCallback:^(NSError *error, NSDictionary *result) {
        if(error){
            return ;
        }
        NSArray *weatherArray = result[@"weather"];
        currentWeather.city = result[@"name"];
        currentWeather.currentTemperature = [result[@"main"][@"temp"] integerValue];
        currentWeather.highTemperature = [result[@"main"][@"temp_max"] integerValue];
        currentWeather.lowTemperature = [result[@"main"][@"temp_min"] integerValue];
        currentWeather.humidity = [result[@"main"][@"humidity"] integerValue];
        currentWeather.pressure = [result[@"main"][@"pressure"] integerValue];
        for (NSDictionary* weatherDictionary in weatherArray){
            currentWeather.condition = weatherDictionary[@"description"];
            currentWeather.iconString = weatherDictionary[@"icon"];
            NSLog(@"%@", currentWeather.iconString);
        }
        _lblCity.text = currentWeather.city;
        _lblTemperature.text = [NSString stringWithFormat: @"%ld°", currentWeather.currentTemperature];
        _lblHilo.text = [NSString stringWithFormat: @"%ld° / %ld°", currentWeather.highTemperature , currentWeather.lowTemperature];
        _lblCondition.text = currentWeather.condition;
        _lblHumidity.text = [NSString stringWithFormat: @"Humidity: %ld%", currentWeather.humidity];
        _lblPressure.text = [NSString stringWithFormat: @"%ld", currentWeather.pressure];
        NSString *imageUrlString = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png" , currentWeather.iconString];
        NSURL *url = [NSURL URLWithString:imageUrlString];
        NSData *dataIcon = [[NSData alloc] initWithContentsOfURL:url];
        _imgIcon.image = [UIImage imageWithData:dataIcon];

    }];
}
-(void)findCurrentLocation
{
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    if ([locationManager locationServicesEnabled])
    {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
    }
    
    
    CLLocation *location = [locationManager location];
    _locationCoordinate2D = [location coordinate];
    
    NSString *str=[[NSString alloc] initWithFormat:@" latitude:%f longitude:%f",_locationCoordinate2D.latitude,_locationCoordinate2D.longitude];
    NSLog(@"%@",str);
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
