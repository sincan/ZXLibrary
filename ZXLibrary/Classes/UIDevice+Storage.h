//
//  UIDevice+Storage.h
//
//
//  Created by Sincan on 2017/10/24.
//  Copyright © 2017年 Xin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Storage)

/**
 当前磁盘已用大小
 
 @return  当前磁盘已用大小
 */
+ (long long)zx_DiskUsedSize;

/**
 当前磁盘总大小
 
 @return  当前磁盘总大小
 */
+ (long long)zx_DiskTotalSize;

/**
 当前磁盘空闲大小
 
 @return  当前磁盘空闲大小
 */
+ (long long)zx_DiskFreeSize;

/**
 当前内存总大小
 
 @return 当前内存总大小
 */
+ (long long)zx_MemoryTotalSize;

/**
 将存储大小转换成存储单位(GB、MB、kB、dB)字符串信息

 @param size 存储大小
 @return 存储单位信息字符串
 */
- (NSString *)zx_StorageInfoWithSize:(long long)size;
@end
