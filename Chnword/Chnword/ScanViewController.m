//
//  ScanViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()

@end

@implementation ScanViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.captureType = AVCaptureDevicePositionBack;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (self.refViewController.qrCodeView.image != nil) {
//        [super stopSession];
//        self.qrCodeView.image = self.refViewController.qrCodeView.image;
//        self.qrCodeView.hidden = NO;
//    }
}


#pragma mark - Overwrite QrSearchViewController Methods

/**
 *  成功扫到文件的方法。
 */
- (void) successedWithString:(NSString *) str
{
    [super successedWithString:str];
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:maskView];
    
    if ([self verifyQrCode:str])
    {
        [self flashOnView:maskView withColor:[UIColor blueColor] duration:0.2];
        [super stopSession];
        NSArray *arr = [str componentsSeparatedByString:@"_"];
        [self resetQrCodeView:[arr objectAtIndex:0]];
    }
    else
    {
        [self flashOnView:maskView withColor:[UIColor redColor] duration:0.2];
    }
}

/**
 *  闪烁的调用方法。
 *  @param view 在那个view上进行闪烁
 *  @param color 闪烁的颜色
 *  @param duration 闪烁的时间
 */
- (void) flashOnView:(UIView *) view withColor:(UIColor *) color duration:(NSTimeInterval) time
{
    [super flashOnView:view withColor:color duration:time];
}

#pragma mark - Private Methods

/**
 *  @abstract 生成二维码并显示
 *
 *
 */
- (void) resetQrCodeView:(NSString *) uuid
{
//    NSString *cardid = [Util generateUUID];
//    NSString *udid = [Util getDeviceUDID];
    // NSString *userid = [Util currentLoginUserId];
//    NSString *str = [NSString stringWithFormat:@"%@_%@_%@", uuid, cardid, udid];
//    self.qrCodeView.image = [QRUtil generateUsingString:str];
//    self.qrCodeView.hidden = NO;
//    self.refViewController.qrCodeView.image = self.qrCodeView.image;
}

/**
 *  @abstract
 *
 *
 */
- (BOOL) verifyQrCode:(NSString *) code
{
    @try
    {
        NSArray *arr = [code componentsSeparatedByString:@"_"];
        if (arr.count != 4)
        {
            return NO;
        }
        NSString *uuid = [arr objectAtIndex:0];
        NSString *udid = [arr objectAtIndex:1];
        NSString *cardid = [arr objectAtIndex:2];
        NSString *devName = [arr objectAtIndex:3];
        
        if ([uuid isEqualToString:@""] || [udid isEqualToString:@""] || [cardid isEqualToString:@""] || [devName isEqualToString:@""]) {
            return NO;
        }
    }
    @catch (NSException *exception)
    {
        return NO;
    }
    @finally
    {
    }
    return YES;
}


@end
