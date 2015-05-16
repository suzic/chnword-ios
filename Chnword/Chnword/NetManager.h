//
//  NetManager.h
//  Chnword
//
//  Created by khtc on 15/5/13.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetManager : NSObject

+ (void) postRequest:(NSString *) url param:(NSDictionary *) param success:(void (^)(id jsonObject)) success fail:(void (^)(void)) fail;

@end
