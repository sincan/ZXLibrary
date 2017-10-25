//
//  ZXBatteryManager.h
//  
//
//  Created by Sincan on 2017/10/24.
//  Copyright © 2017年 Xin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSInteger, ZXDeviceBatteryState) {
    ZXDeviceBatteryStateUnknown,
    ZXDeviceBatteryStateUnplugged,//未充电
    ZXDeviceBatteryStateCharging,//正在充电
    ZXDeviceBatteryStateFull,//充满电
};

@protocol ZXBatteryManagerDelegate;
@interface ZXBatteryManager : NSObject

@property (nonatomic, weak) id<ZXBatteryManagerDelegate> delegate;

/** 电池容量 */
@property (nonatomic, readonly) NSUInteger capacity;

/** 剩余电量 百分比 */
@property (nonatomic, readonly) NSUInteger levelPercent;

/** 电池电压 */
@property (nonatomic, readonly) CGFloat voltage;

/** 剩余电量 容量（毫安）*/
@property (nonatomic, readonly) NSUInteger levelMAH;

/** 电池状态 */
@property (nonatomic, assign)   ZXDeviceBatteryState batteryState;

+ (instancetype)sharedManager;

/** 开始监测电池电量 */
- (void)startBatteryMonitoring;

/** 停止监测电池电量 */
- (void)stopBatteryMonitoring;

@end

@protocol ZXBatteryManagerDelegate <NSObject>

@optional
- (void)batteryDidUpdated:(ZXBatteryManager *)battery ;

@end
