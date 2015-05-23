//
//  NetManager.m
//  Chnword
//
//  Created by khtc on 15/5/13.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "NetManager.h"
#import "NSObject+JSON.h"

@implementation NetManager

+ (void) postRequest:(NSString *) url param:(NSDictionary *) param success:(void (^)(id jsonObject)) success fail:(void (^)(void)) fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSLog(@"%@", param);
    
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //调试使用
//        NSError *error;
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"dict %@", dict);
        
        NSLog(@"%@", responseObject);
        NSLog ( @"operation: %@" , operation.responseString);
        if (success) {
            success(responseObject);
            //调试使用
//            success(dict);
        }
        
        

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        if (fail) {
            fail();
        }
    }];
}

+ (void)JSONDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail
{
    
}

@end
