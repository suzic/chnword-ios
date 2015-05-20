//
//  UserViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *html = @"<html><body bgcolor='#fff' width='100%' height='100%'><p color='#000'>请妥善保管您的用户码信息</p><p>该信息记录了您软件内购买的记录，从而在购买实体产品时可获得相应的优惠。</p><p>同时您可以在不同设备上使用您的用户码登录，并享用已解锁的内容。</p><p>同一时刻，仅允许一个设备使用该用户码。一个设备上使用用户码登录会将使用同一用户的其他设备弹出到登录界面。</p></body></html>";
    
    [self.webView loadHTMLString:html baseURL:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
