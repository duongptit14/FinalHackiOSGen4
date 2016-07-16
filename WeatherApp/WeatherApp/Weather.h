//
//  Weather.h
//  WeatherApp
//
//  Created by Thuong on 7/15/16.
//  Copyright © 2016 Thuong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
@property NSInteger* currentTemperature;
@property NSInteger* highTemperature;
@property NSInteger* lowTemperature;
@property NSString* city;
@property NSString* iconString;
@property NSString* condition;
@property NSInteger* pressure;
@property NSInteger* humidity;

@end
