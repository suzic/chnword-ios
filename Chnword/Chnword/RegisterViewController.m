//
//  RegisterViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加闪屏
    UIViewController *splashViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SplashViewController"];
    [self.view.window addSubview:splashViewController.view];
    
    //添加用户指引
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:CHNWORD_USER_FIRSTLOGIN]) {
        UIViewController *guideViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GuideViewController"];
        [self.view.window insertSubview:guideViewController.view aboveSubview:splashViewController.view];
    }
    
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
    [self performSegueWithIdentifier:@"PushToMain" sender:nil];
}

/**
 *  登录按钮点击
 */
- (IBAction) loginButtonClicked:(id)sender
{
    [self performSegueWithIdentifier:@"PushToMain" sender:nil];
}

@end
