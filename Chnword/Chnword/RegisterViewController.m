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
#import "DataUtil.h"



@interface RegisterViewController ()

@property (nonatomic, retain) IBOutlet UITextField *usercode;
@property (nonatomic, assign) Rect viewRect;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardStart:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardEnd:) name:UIKeyboardDidHideNotification object:nil];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) handleKeyBoardStart:(NSNotification *) notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardEndFrame = [aValue CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
    
//    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    CGRect rect = self.view.frame;
    
    rect.origin.y = - 70;
    self.view.frame = rect;
    
}

- (void) handleKeyboardEnd:(NSNotification *) notification
{
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    rect.origin.x = 0;
    self.view.frame = rect;
}


/**
 *  试用
 */
- (IBAction) tryButtonClicked:(id)sender
{
//    [self performSegueWithIdentifier:@"PushToMain" sender:nil];
    
    NSString *opid = [Util generateUuid];
    NSString *deviceId = [Util getUdid];
    NSString *userid = [Util generateUuid];
    
    //本地用户存储
    NSDictionary *param = [NetParamFactory
                           registParam:opid
                           userid:userid
                           device:deviceId
                           userCode:userid
                           deviceId:deviceId
                           session:[Util generateUuid]
                           verify:@"verify"];
    [NetManager postRequest:URL_REGIST param:param success:^(id json){
        
        NSLog(@"success with json: %@", json);
        
        NSDictionary *dict = json;
        
        if (dict) {
            NSString *result = [dict objectForKey:@"result"];
            if (result && [@"1" isEqualToString:result]) {
                //注册成功
                [DataUtil setDefaultUser:userid];
                [self performSegueWithIdentifier:@"PushToMain" sender:nil];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
        
    }fail:^ (){
        NSLog(@"fail ");
        
    }];

    
    
    
}

/**
 *  登录按钮点击
 */
- (IBAction) loginButtonClicked:(id)sender
{
    NSString *opid = [Util generateUuid];
    NSString *userid = self.usercode.text;
    
    NSString *deviceId = [Util getUdid];
    
    NSDictionary *param = [NetParamFactory registParam:opid userid:userid device:deviceId userCode:userid deviceId:deviceId session:[Util generateUuid] verify:@"verify"];
    [NetManager postRequest:URL_REGIST param:param success:^(id json){
        
        NSLog(@"success with json: %@", json);
        
    }fail:^ (){
        NSLog(@"fail ");
    }];
    
    
    /*
    NSString *activeCode = self.activeCodeField.text;
    
    NSString *opid = [Util generateUuid];
    NSString *deviceId = [Util getUdid];
    NSString *userid = [DataUtil getDefaultUser];
    
    //本地用户存储
    //    [DataUtil setDefaultUser:deviceId];
    [self.hud show:YES];
    
    //    NSDictionary *param = [NetParamFactory registParam:opid userid:userid device:deviceId userCode:userid  deviceId:deviceId session:[Util generateUuid] verify:@"verify"];
    NSDictionary *param = [NetParamFactory verifyParam:opid userid:userid device:deviceId code:activeCode user:userid];
    [NetManager postRequest:URL_VERIFY param:param success:^(id json){
        
        NSLog(@"success with json: %@", json);
        
        [self.hud hide:YES];
        
        NSDictionary *dict = json;
        
        NSString *str = [dict objectForKey:@"result"];
        if (str && [@"1" isEqualToString:str]) {
            //成功
            
            NSDictionary *data = [dict objectForKey:@"data"];
            if (data) {
                
                NSString *unlock_all = [dict objectForKey:@"unlock_all"];
                NSArray *zones = [dict objectForKey:@"unlock_zone"];
                if (unlock_all && [@"1" isEqualToString:unlock_all]) {
                    //解锁全部的
                    NSLog(@"unlock——all");
                    [DataUtil setUnlockAllModelsForUser:[DataUtil getDefaultUser]];
                    
                    
                } else {
                    //得到解锁的其他条目,处理unlock_zone.
                    for (NSString *unlocked in zones) {
                        NSLog(@"unlocked %@", unlocked);
                    }
                    
                    [DataUtil setUnlockModel:userid models:zones];
                    
                    
                }
                NSString *message = [NSString stringWithFormat:@"解锁成功：\n data \n %@", data];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                
            }else {
                NSString *message = [dict objectForKey:@"message"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
            
        }
        
    }fail:^ (){
        NSLog(@"fail ");
        [self.hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];

    */
    
    [self performSegueWithIdentifier:@"PushToMain" sender:nil];
}

/**
 *  隐藏键盘
 */
- (IBAction) hiddenKeyBoard:(id)sender
{
    if ([self.usercode isFirstResponder] && [self.usercode canResignFirstResponder]) {
        [self.usercode resignFirstResponder];
    }
}





@end
