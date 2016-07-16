//
//  ViewController.h
//  WeatherApp
//
//  Created by Thuong on 7/15/16.
//  Copyright © 2016 Thuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController.h>


@import CoreLocation;
@interface ViewController : UIViewController<CLLocationManagerDelegate , SWRevealViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblHilo;
@property (weak, nonatomic) IBOutlet UILabel *lblTemperature;
@property (weak, nonatomic) IBOutlet UILabel *lblCondition;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblHumidity;
@property (weak, nonatomic) IBOutlet UILabel *lblPressure;

@end

