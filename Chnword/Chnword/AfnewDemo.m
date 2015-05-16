//
//  AfnewDemo.m
//  Chnword
//
//  Created by khtc on 15/5/11.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "AfnewDemo.h"
#import "AFNetworking.h"

@implementation AfnewDemo


- (void) test {
    
    NSString *urlPath = @"http://10.0.8.8/sns/my/user_list.php";
    
    //  AFNetworking VS ASI 最大的优势是 有ARC支持
    
    //  AFNetworking目标是赶上ASI, AFNetworking致辞NSURLConnection和NSURLSession
    
    //  AFNetworking是使用NSURLConnection 和 NSURLSession
    
    //  #improt "AFNetworking.h"
    
    
    
    //1.使用 NSURLConnection版本的AFNetworking
    
    //1.1创建一个AFN管理对象
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    
    //1.2告诉manager只下载原始数据, 不要解析数据(一定要写)
    
    //     AFN即可以下载网络数据, 又可以解析json数据,如果不写下面的  自动就解析json
    
    //     由于做服务器的人返回json数据往往不规范, 凡是AFN又检查很严格,导致json解析往往失败
    
    //     下面这句话的意思是 告诉AFN千万别解析, 只需要给我裸数据就可以
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    //1.3使用GET下载数据
    
    NSDictionary *params = @{@"page" : @"2"};//表示第几页
    
    [manager GET:urlPath parameters:params success:
     
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSData *data = operation.responseData;
         
         NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
         NSLog(@"parase json is%@",dict);
         
     }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"下载错误 is %@",error);
             
         }];
    
    
    
    
    
    
    
    
    //2.使用NSURLSession版本的AFNetworking
    
    //2.1创建一个AFN管理对象
    
    AFHTTPSessionManager *smanager = [AFHTTPSessionManager manager];
    
    
    
    //2.2告诉manager只下载原始数据, 不要解析数据(一定要写
    
    smanager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    //2.3使用GET下载数据
    
    [smanager GET:urlPath parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSData *data = responseObject;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"parase session is %@",dict);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"下载错误 %@",error);
        
    }];
    
    
    
}
@end
