//
//  DataUtil.h
//  Chnword
//
//  Created by khtc on 15/5/17.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtil : NSObject

/**
 *  添加一个用户
 */
+ (void) addUser:(NSString *) userCode;

/**
 *  为用户添加解锁条目
 */
+ (void) addItemForUser:(NSString *) userCode item:(NSArray *) list;

/**
 *  获得所有的用户
 */
+ (NSArray *) getAllUser;

/**
 *  获得指定用户下的解锁条目
 */
+ (NSArray *) getListByUserCode:(NSString *) userCode;


@end
