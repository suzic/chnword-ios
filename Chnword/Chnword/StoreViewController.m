//
//  StoreViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreViewTableViewCell.h"
#import "DataUtil.h"
#import "Util.h"
#import "MBProgressHUD.h"


@interface StoreViewController ()

@property (nonatomic, retain) NSArray *stuffs;

@property (nonatomic, retain) MBProgressHUD *hud;

@end

@implementation StoreViewController

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

#pragma - KeyBoard

- (void) handleKeyBoardStart:(NSNotification *) notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardEndFrame = [aValue CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
    
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    CGRect rect = self.view.frame;
    
    rect.origin.y = - keyboardHeight;
    self.view.frame = rect;
    
}

- (void) handleKeyboardEnd:(NSNotification *) notification
{
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    rect.origin.x = 0;
    self.view.frame = rect;
}


#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stuffs.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreViewTableViewCell *cell;
    
    cell = (StoreViewTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"StoreViewTableViewCell" forIndexPath:indexPath];
    
//    cell.title.text = [self.gameNames objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - getter
- (NSArray *) stuffs
{
    if (!_stuffs) {
        _stuffs = [NSArray arrayWithObjects:@"商品1", @"商品2", @"商品3", @"商品4", nil];
    }
    return _stuffs;
}


/**
 *  购买点击
 */
- (IBAction) buyStuff:(id)sender
{
    
}

/**
 *
 */
- (IBAction) submitCode:(id)sender
{
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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"解锁成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
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
    
}

/**
 *  隐藏键盘
 */
- (IBAction) hideKeyBoard:(id)sender
{
    if ([self.activeCodeField canResignFirstResponder]) {
        [self.activeCodeField resignFirstResponder];
    }
}



#pragma mark - getter method
- (MBProgressHUD *) hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        _hud.color = [UIColor clearColor];//这儿表示无背景
        //显示的文字
        _hud.labelText = @"Test";
        //细节文字
        _hud.detailsLabelText = @"Test detail";
        //是否有庶罩
        _hud.dimBackground = YES;
        [self.navigationController.view addSubview:_hud];
    }
    return _hud;
}

@end
