//
//  SplashViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "SplashViewController.h"
#import "NSObject+Delay.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    NSLog(@"remove from window begin");
    [self performBlock:^{
        NSLog(@"after remove from window");
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults boolForKey:CHNWORD_USER_FIRSTLOGIN]) {
            [self performSegueWithIdentifier:@"GuideViewController" sender:nil];
        }else {
            [self performSegueWithIdentifier:@"RegisterViewController" sender:nil];
        }
    } afterDelay:2];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
