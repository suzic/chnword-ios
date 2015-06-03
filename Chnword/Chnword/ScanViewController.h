//
//  ScanViewController.h
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <TesseractOCR.h>


@interface ScanViewController : UIViewController <G8TesseractDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//@property (assign, nonatomic) ShowCardViewController* refViewController;

@property (nonatomic, assign) AVCaptureDevicePosition captureType;


@property (nonatomic, retain) IBOutlet UIImageView *qrCodeView;

@property (weak, nonatomic) IBOutlet UIImageView *imageToRecognize;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

//- (IBAction)openCamera:(id)sender;
//- (IBAction)recognizeSampleImage:(id)sender;


@end
