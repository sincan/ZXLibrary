//
//  ZXDeviceDataLibrery.h
//
//
//  Created by Sincan on 2017/10/24.
//  Copyright © 2017年 Xin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXDeviceDataLibrary : NSObject

+ (instancetype)sharedLibrary;

/**
 获取设备名称

 @return 设备名称
 */
- (const NSString *)diviceName;

/**
 获取设备电池容量，单位 mA 毫安
 
 @return 电池容量
 */
- (NSInteger)batteryCapacity;

/**
 获取电池电压，单位 V 福特

 @return 电池电压
 */
- (CGFloat)batterVolocity;

/**
 获取CPU处理器名称

 @return CPU名称
 */
- (const NSString *)CPUProcessor;


/**
 获取CPU处理器频率

 @return CPU频率
 */
- (NSInteger)CPUFrequency;

@end
