//
//  DataUtil.h
//  Chnword
//
//  Created by khtc on 15/5/17.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtil : NSObject



//默认用户或者其他

+ (void) setDefaultUser:(NSString *) userCode;

+ (NSString *) getDefaultUser;

//首次登陆
+ (BOOL) isFirstLogin;


/**
 *  添加一个用户
 */
+ (void) addUser:(NSString *) userCode;

// ----- default
+ (void) setDefaultModule:(NSArray *) modules;

+ (NSArray *) getDefaultModule;


+ (void) setDefaultWord:(NSArray *) word forModule:(NSString *) moduleCode;


+ (NSArray *) getDefaultWord:(NSString *) moduleCode;

//----  users
+ (void) setDefaultModule:(NSArray *) modules forUser:(NSString *) userCode;


+ (NSArray *) getDefaultModule:(NSString *) userCode;


+ (void) setDefaultWord:(NSArray *) word forModule:(NSString *) moduleCode andUser:(NSString *) userCode;



+ (NSArray *) getDefaultWord:(NSString *) moduleCode forUser:(NSString *) userCode;


@end
