//
//  UIDevice+Storage.m
// 
//
//  Created by Sincan on 2017/10/24.
//  Copyright © 2017年 Xin. All rights reserved.
//

#import "UIDevice+Storage.h"
#import <sys/mount.h>

@implementation UIDevice (Storage)

+ (long long)zx_DiskUsedSize {
    unsigned long long usedSpace = [UIDevice zx_DiskTotalSize];
    if (usedSpace <= 0) {
        return usedSpace;
    }
    return usedSpace - [UIDevice zx_DiskFreeSize];
}

+ (long long)zx_DiskTotalSize {
    struct statfs buf;
    unsigned long long totalSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        totalSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return totalSpace;
}

+ (long long)zx_DiskFreeSize {
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}

+ (long long)zx_MemoryTotalSize {
    return [[NSProcessInfo processInfo] physicalMemory];
}

- (NSString *)zx_StorageInfoWithSize:(long long)size {
    if (size>1024*1024*1024) {
        return [NSString stringWithFormat:@"%.1fGB",size/1024.f/1024.f/1024.f];//G单位
    }
    if (size<1024*1024*1024 && size>1024*1024) {
        return [NSString stringWithFormat:@"%.1fMB",size/1024.f/1024.f];//M单位
    }
    if (size>1024 && size<1024*1024) {
        return [NSString stringWithFormat:@"%.1fkB",size/1024.f]; //K单位
    }else {
        return [NSString stringWithFormat:@"%.1lldB",size];//转成B单位
    }
}
@end
