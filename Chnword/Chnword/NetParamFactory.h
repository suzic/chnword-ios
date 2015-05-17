//
//  NetParamFactory.h
//  Chnword
//
//  Created by khtc on 15/5/13.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetParamFactory : NSObject

/**
 *
 */
+ (NSDictionary *) verifyParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId code:(NSString *) code user:(NSString *) user;

/**
 *
 */
+ (NSDictionary *) listParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId page:(int) page size:(int) size;

/**
 *  @depressed
 */
+ (NSDictionary *) subListParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId lists:(NSArray *) zoneList page:(int) page size:(int) size;

+ (NSDictionary *) subListParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId zone:(NSString *) zoneList page:(int) page size:(int) size;

/**
 *
 */
+ (NSDictionary *) wordParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId word:(NSString *) word;

/**
 *
 */
+ (NSDictionary *) showParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId wordCode:(NSString *) wordCode;

/**
 *
 */
+ (NSDictionary *) registParam:(NSString *) opid userid:(NSString *) userid device:(NSString *) deviceId userCode:(NSString *) userCode deviceId:(NSString *) deviceId session:(NSString *) sessionId verify:(NSString *) verifyCode;
@end
