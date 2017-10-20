//
//  CYKeychainStore.h
//  CYKeychainStore
//
//  Created by DeepAI on 2017/10/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

/**
 Using keychain save datas in local device needn`t to turn on Capabilities.
 */

#import <Foundation/Foundation.h>


@interface CYKeychainStore : NSObject

+ (void)setObject:(id)object forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key;

+ (void)clearRecordForKey:(NSString *)key;

@end
