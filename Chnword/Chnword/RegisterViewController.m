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
    
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
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
    NSString *userid = @"userid";
    
    //网络测试入口
//    NSString *url = @"http://app.3000zi.com/api/verify.php";
//    NSDictionary *param = [NetParamFactory verifyParam:opid userid:userid device:deviceId code:@"code" user:@"user"];
//    [NetManager postRequest:url param:param success:^(id json){
//        
//        NSLog(@"success with json: %@", json);
//        
//    }fail:^ (){
//        NSLog(@"fail ");
//    }];

    
//    NSString *url = @"http://app.3000zi.com/api/list.php";
//    NSDictionary *param = [NetParamFactory listParam:opid userid:userid device:deviceId page:0 size:0];
//    [NetManager postRequest:url param:param success:^(id json){
//        
//        NSLog(@"success with json: %@", json);
//        
//    }fail:^ (){
//        NSLog(@"fail ");
//    }];
    
//    NSString *url = @"http://app.3000zi.com/api/sublist.php";
//    NSDictionary *param = [NetParamFactory subListParam:opid userid:userid device:deviceId lists:@[@"zone_0001"]];
//    [NetManager postRequest:url param:param success:^(id json){
//        
//        NSLog(@"success with json: %@", json);
//        
//    }fail:^ (){
//        NSLog(@"fail ");
//    }];

    NSString *url = @"http://app.3000zi.com/api/word.php";
    NSDictionary *param = [NetParamFactory wordParam:opid userid:userid device:deviceId word:@"王"];
    [NetManager postRequest:url param:param success:^(id json){
        
        NSLog(@"success with json: %@", json);
        
    }fail:^ (){
        NSLog(@"fail ");
    }];
    
//    NSString *url = @"http://app.3000zi.com/api/show.php";
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
    NSString *opid = [Util generateUuid];
    NSString *userid = self.usercode.text;
    
    NSString *deviceId = [Util getUdid];
    
    NSString *url = @"http://app.3000zi.com/api/regist.php";
    NSDictionary *param = [NetParamFactory registParam:opid userid:userid device:deviceId userCode:userid deviceId:deviceId session:@"sessionId" verify:@"verify"];
    [NetManager postRequest:url param:param success:^(id json){
        
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
