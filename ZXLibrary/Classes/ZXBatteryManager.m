//
//  ZXBatteryManager.m
//  
//
//  Created by Sincan on 2017/10/24.
//  Copyright © 2017年 Xin. All rights reserved.
//

#import "ZXBatteryManager.h"
#import "ZXDeviceDataLibrary.h"
@interface ZXBatteryManager ()

@property (nonatomic, assign) BOOL batteryMonitoringEnabled;
@property (nonatomic, assign) NSUInteger capacity;
@property (nonatomic, assign) NSUInteger levelPercent;
@property (nonatomic, assign) CGFloat voltage;
@property (nonatomic, assign) NSUInteger levelMAH;
@end

@implementation ZXBatteryManager

+ (instancetype)sharedManager {
    static ZXBatteryManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ZXBatteryManager alloc] init];
    });
    return _manager;
}

- (void)startBatteryMonitoring {
    if (!self.batteryMonitoringEnabled) {
        self.batteryMonitoringEnabled = YES;
        UIDevice *device = [UIDevice currentDevice];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_batteryLevelUpdatedNotifi:)
                                                     name:UIDeviceBatteryLevelDidChangeNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_batteryStatusUpdatedNotifi:)
                                                     name:UIDeviceBatteryStateDidChangeNotification
                                                   object:nil];
        
        [device setBatteryMonitoringEnabled:YES];
        
        if ([device batteryState] != UIDeviceBatteryStateUnknown) {
            [self doUpdateBatteryStatus];
        }
    }
}

- (void)stopBatteryMonitoring {
    if (self.batteryMonitoringEnabled) {
        self.batteryMonitoringEnabled = NO;
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)_batteryLevelUpdatedNotifi:(NSNotification*)notification {
    [self doUpdateBatteryStatus];
}

- (void)_batteryStatusUpdatedNotifi:(NSNotification*)notification {
    [self doUpdateBatteryStatus];
}

- (void)doUpdateBatteryStatus {
    float batteryMultiplier = [[UIDevice currentDevice] batteryLevel];
    self.levelPercent = batteryMultiplier * 100;
    self.levelMAH =  self.capacity * batteryMultiplier;
    switch ([[UIDevice currentDevice] batteryState]) {
        case UIDeviceBatteryStateCharging:
            if (self.levelPercent == 100) {
                self.batteryState = ZXDeviceBatteryStateFull;
            } else {
                self.batteryState = ZXDeviceBatteryStateCharging;
            }
            break;
        case UIDeviceBatteryStateFull:
            self.batteryState = ZXDeviceBatteryStateFull;
            break;
        case UIDeviceBatteryStateUnplugged:
            self.batteryState = ZXDeviceBatteryStateUnplugged;
            break;
        case UIDeviceBatteryStateUnknown:
            self.batteryState = ZXDeviceBatteryStateUnknown;
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(batteryDidUpdated:)]) {
        [self.delegate batteryDidUpdated:self];
    }
}

- (CGFloat)voltage {
    return [[ZXDeviceDataLibrary sharedLibrary] batterVolocity];
}

- (NSUInteger)capacity {
    return [[ZXDeviceDataLibrary sharedLibrary] batteryCapacity];
}


@end
