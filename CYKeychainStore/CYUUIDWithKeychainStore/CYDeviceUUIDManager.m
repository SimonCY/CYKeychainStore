//
//  CYDeviceUUIDManager.m
//  CYKeychainStore
//
//  Created by DeepAI on 2017/10/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYDeviceUUIDManager.h"
#import "CYKeychainStore.h"

static NSString *CYKeychainStoreUUIDKey = @"CYKeychainStoreUUIDKey";

@implementation CYDeviceUUIDManager

+ (NSString *)deviceUUID {
    
    //获取项目的bundle ID
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    //根据bundle ID拼接一个自定义的key用来作为keychain里面的唯一标示
    //NSString *keyUUid = [NSString stringWithFormat:@"%@.uuid",bundleId];
    //将bundle ID作为唯一key在keychain里面获取保存的uuid
    NSString * UUIDStr = (NSString *)[CYKeychainStore objectForKey:CYKeychainStoreUUIDKey];
    
    //首次执行该方法时，uuid为空
    if ([UUIDStr isEqualToString:@""] || !UUIDStr)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        UUIDStr = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [CYKeychainStore setObject:UUIDStr forKey:CYKeychainStoreUUIDKey];
        
    }
    return UUIDStr;
}
@end
