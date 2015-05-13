//
//  NetManager.h
//  Chnword
//
//  Created by khtc on 15/5/13.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject

+ (void) postRequest:(NSString *) url param:(NSDictionary *) param success:((^)(void)) success fail:((^)(void)) fail;

@end
