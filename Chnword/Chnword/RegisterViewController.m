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
