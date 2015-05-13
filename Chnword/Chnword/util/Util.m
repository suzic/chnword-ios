//
//  Util.m
//  Chnword
//
//  Created by khtc on 15/5/13.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (NSString *) generateUuid;
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    
    NSString *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString;
}

+ (NSString *) getUdid
{
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}
@end
