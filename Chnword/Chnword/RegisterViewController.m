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
