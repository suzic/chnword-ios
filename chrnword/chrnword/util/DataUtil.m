//
//  DataUtil.m
//  Chnword
//
//  Created by khtc on 15/5/17.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "DataUtil.h"

#define Submit_Code_Key @"Submit_Code_Key"
#define Submit_Code_Zone @"Submit_Code_Zone"
#define Submit_Code_ALL @"Submit_Code_ALL"
#define Submit_Code_List @"Submit_Code_List"

#define Submit_Code_None @"Submit_Code_None"
#define Submit_Code_Till @"Sbumit_Code_Till"


@implementation DataUtil

/**
 *  添加一个用户
 */
+ (void) addUser:(NSString *) userCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *users = [defaults objectForKey:Submit_Code_Key];
    if (users) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:users];
        [arr addObject:userCode];
        [defaults setObject:arr forKey:Submit_Code_Key];
    } else {
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:userCode, nil];
        [defaults setObject:arr forKey:Submit_Code_Key];
    }
    [defaults synchronize];
}

/**
 *  为用户添加解锁条目
 * @param list nsarray集合
 */
+ (void) addItemForUser:(NSString *) userCode item:(NSArray *) list
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dicts  = [defaults objectForKey:userCode];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dicts];
    if (dict) {
        NSString *str = [dict objectForKey:Submit_Code_ALL];
        if (!str) {
            [dict setObject:Submit_Code_None forKey:Submit_Code_ALL];
            str = Submit_Code_None;
        }
        
        //设置list中的数值
        for (NSString *str in list) {
            [dict setObject:Submit_Code_Till forKey:str];
        }
        
        [defaults setObject:dict forKey:Submit_Code_List];
        
        
        
    } else {
        NSMutableDictionary *adict = [[NSMutableDictionary alloc] init];
        [adict setObject:Submit_Code_None forKey:Submit_Code_ALL];
        
        //设置list中的数值
        for (NSString *str in list) {
            [dict setObject:Submit_Code_Till forKey:str];
        }
        
        [defaults setObject:adict forKey:userCode];
        
    }
    [defaults synchronize];

}

/**
 *  获得所有的用户
 */
+ (NSArray *) getAllUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *users = [defaults objectForKey:Submit_Code_Key];
    
    return users;

}

/**
 *  获得指定用户下的解锁条目
 */
+ (NSArray *) getListByUserCode:(NSString *) userCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dict = [defaults objectForKey:userCode];
    NSMutableArray *result = [NSMutableArray array];
    if (dict) {
        NSEnumerator * enumeratorKey = [dict keyEnumerator];
        for (NSString *key in enumeratorKey) {
            NSString *val = [dict objectForKey:key];
            if ([val isEqualToString:Submit_Code_Till]) {
                [result addObject:key];
            }
        }
        
    }
    
    return result;

}

@end
