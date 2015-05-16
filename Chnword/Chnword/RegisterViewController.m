//
//  RegisterViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "RegisterViewController.h"
#import "NetParamFactory.h"
#import "NetManager.h"
#import "Util.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  试用
 */
- (IBAction) tryButtonClicked:(id)sender
{
//    [self performSegueWithIdentifier:@"PushToMain" sender:nil];
    
    NSString *opid = [Util generateUuid];
    NSString *deviceId = [Util getUdid];
    NSString *userid = @"userid";
    
    //网络测试入口
    NSString *url = @"http://app.3000zi.com/api/verify.php";
    NSDictionary *param = [NetParamFactory verifyParam:opid userid:userid device:deviceId code:@"code" user:@"user"];
    [NetManager postRequest:url param:param success:^(id json){
        
        NSLog(@"success with json: %@", json);
        
    }fail:^ (){
        NSLog(@"fail ");
    }];

    
//    NSString *url = @"http://app.3000zi.com/api/list.php";
//    NSDictionary *param = [NetParamFactory listParam:opid userid:userid device:deviceId page:0 size:0];
//    [NetManager postRequest:url param:param success:^(id json){
//        
//        NSLog(@"success with json: %@", json);
//        
//    }fail:^ (){
//        NSLog(@"fail ");
//    }];
    
//    NSString *url = @"";
//    NSDictionary *param = [NetParamFactory subListParam:opid userid:userid device:deviceId lists:@[@"zone_0001"]];
//    [NetManager postRequest:url param:param success:^(id json){
//        
//        NSLog(@"success with json: %@", json);
//        
//    }fail:^ (){
//        NSLog(@"fail ");
//    }];

//    NSString *url = @"";
//    NSDictionary *param = [NetParamFactory wordParam:opid userid:userid device:deviceId word:@"天"];
//    [NetManager postRequest:url param:param success:^(id json){
//        
//        NSLog(@"success with json: %@", json);
//        
//    }fail:^ (){
//        NSLog(@"fail ");
//    }];
    
//    NSString *url = @"";
//    NSDictionary *param = [NetParamFactory showParam:opid userid:userid device:deviceId wordCode:@"zone_0001"];
//    [NetManager postRequest:url param:param success:^(id json){
//        
//        NSLog(@"success with json: %@", json);
//        
//    }fail:^ (){
//        NSLog(@"fail ");
//    }];

//    NSString *url = @"http://app.3000zi.com/api/regist.php";
//    NSDictionary *param = [NetParamFactory registParam:opid userid:userid device:deviceId userCode:@"usercode" deviceId:deviceId session:@"sessionId" verify:@"verify"];
//    [NetManager postRequest:url param:param success:^(id json){
//        
//        NSLog(@"success with json: %@", json);
//        
//    }fail:^ (){
//        NSLog(@"fail ");
//    }];

    
    
    
}

/**
 *  登录按钮点击
 */
- (IBAction) loginButtonClicked:(id)sender
{
    [self performSegueWithIdentifier:@"PushToMain" sender:nil];
}

@end
