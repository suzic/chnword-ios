//
//  NetParamFactory.m
//  Chnword
//
//  Created by khtc on 15/5/13.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "NetParamFactory.h"

@implementation NetParamFactory

/**
 *
 */
+ (NSDictionary *) verifyParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId code:(NSString *) code user:(NSString *) user
{
    NSDictionary *dict = @{@"opid":opid,
                           @"userid": userid,
                           @"device": deviceId,
                           @"param": @{
                                   @"code": code,
                                   @"user": user}
            };
    
    return dict;
}

/**
 *
 */
+ (NSDictionary *) listParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId page:(int) page size:(int) size
{
    NSDictionary *dict = @{@"opid":opid,
                           @"userid": userid,
                           @"device": deviceId,
                           @"param": @{
                                   @"page": [NSString stringWithFormat:@"%d", page],
                                   @"size": [NSString stringWithFormat:@"%d", size]}
                           };
    
    return dict;
}

/**
 *
 */
+ (NSDictionary *) subListParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId lists:(NSArray *) zoneList page:(int) page size:(int) size
{
    NSDictionary *dict = @{@"opid":opid,
                           @"userid": userid,
                           @"device": deviceId,
                           @"param": @{
                                   @"list": zoneList,
                                   @"page": [NSString stringWithFormat:@"%d", page],
                                   @"size": [NSString stringWithFormat:@"%d", size]}
                           };
    
    return dict;
}

/**
 *
 */
+ (NSDictionary *) subListParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId zone:(NSString *) zoneList page:(int) page size:(int) size
{
    NSDictionary *dict = @{@"opid":opid,
                           @"userid": userid,
                           @"device": deviceId,
                           @"param": @{
                                   @"list": zoneList,
                                   @"page": [NSString stringWithFormat:@"%d", page],
                                   @"size": [NSString stringWithFormat:@"%d", size]}
                           };
    
    return dict;
}

/**
 *
 */
+ (NSDictionary *) wordParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId word:(NSString *) word
{
    NSDictionary *dict = @{@"opid":opid,
                           @"userid": userid,
                           @"device": deviceId,
                           @"param": @{
                                   @"word": word}
                           };
    
    return dict;
}

/**
 *
 */
+ (NSDictionary *) showParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId wordCode:(NSString *) wordCode
{
    NSDictionary *dict = @{@"opid":opid,
                           @"userid": userid,
                           @"device": deviceId,
                           @"param": @{
                                   @"word_code": wordCode}
                           };
    
    return dict;
}

/**
 *
 */
+ (NSDictionary *) registParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId userCode:(NSString *) userCode deviceId:(NSString *) device session:(NSString *) sessionId verify:(NSString *) verifyCode
{
    NSDictionary *dict = @{@"opid":opid,
                           @"userid": userid,
                           @"device": deviceId,
                           @"param": @{
                                   @"usercode": userCode,
                                   @"deviceid": device,
                                   @"session": sessionId,
                                   @"verify": verifyCode}
                           };
    
    return dict;
}


@end
