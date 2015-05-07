//
//  ScanViewController.h
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ScanViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

//@property (assign, nonatomic) ShowCardViewController* refViewController;

@property (nonatomic, assign) AVCaptureDevicePosition captureType;


@property (nonatomic, retain) IBOutlet UIImageView *qrCodeView;


@end
