//
//  CYKeychainStore.m
//  CYKeychainStore
//
//  Created by DeepAI on 2017/10/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYKeychainStore.h"

@implementation CYKeychainStore

#pragma mark - pravite

+ (NSMutableDictionary *)keychainQueryForKey:(NSString *)key {
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys: (id)kSecClassGenericPassword,(id)kSecClass, key, (id)kSecAttrService, key, (id)kSecAttrAccount, (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible, nil, nil];
}

#pragma mark - public

+ (void)setObject:(id)object forKey:(NSString *)key {
    
    // Get search dictionary
    NSMutableDictionary *keychainQuery = [self keychainQueryForKey:key];
    // Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    // Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:(id)kSecValueData];
    // Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)objectForKey:(NSString *)key {
    
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self keychainQueryForKey:key];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", key, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)clearRecordForKey:(NSString *)key {
    
    NSMutableDictionary *keychainQuery = [self keychainQueryForKey:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

 
@end
