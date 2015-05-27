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

// ----- default
+ (void) setDefaultModule:(NSArray *) modules
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:modules forKey:@"DEFAULT_MODULE"];
    [defaults synchronize];
}

+ (NSArray *) getDefaultModule
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [defaults objectForKey:@"DEFAULT_MODULE"];
    if (arr) {
        return arr;
    }else {
        return [NSArray array];
    }
}


+ (void) setDefaultWord:(NSArray *) word forModule:(NSString *) moduleCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:word forKey:[NSString stringWithFormat:@"%@_DEFAULT_MODULE_WORDS", moduleCode]];
    [defaults synchronize];
}


+ (NSArray *) getDefaultWord:(NSString *) moduleCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *words = [defaults objectForKey:[NSString stringWithFormat:@"%@_DEFAULT_MODULE_WORDS", moduleCode]];
    if (words) {
        return words;
    } else {
        return [NSArray array];
    }
}

//----  users
+ (void) setDefaultModule:(NSArray *) modules forUser:(NSString *) userCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:modules forKey:[NSString stringWithFormat:@"%@_DEFAULT_MODULE", userCode]];
    [defaults synchronize];
    
}


+ (NSArray *) getDefaultModule:(NSString *) userCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *modules = [defaults objectForKey:[NSString stringWithFormat:@"%@_DEFAULT_MODULE", userCode]];
    if (modules) {
        return modules;
    } else {
        return [NSArray array];
    }
}


+ (void) setDefaultWord:(NSArray *) word forModule:(NSString *) moduleCode andUser:(NSString *) userCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:word forKey:[NSString stringWithFormat:@"%@_%@_MODULE_WORD", userCode, moduleCode]];
    [defaults synchronize];
    
}



+ (NSArray *) getDefaultWord:(NSString *) moduleCode forUser:(NSString *) userCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *words = [defaults objectForKey:[NSString stringWithFormat:@"%@_%@_MODULE_WORD", userCode, moduleCode]];
    if (words) {
        return words;
    } else {
        return [NSArray array];
    }
}

@end
