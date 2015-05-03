//
//  ScanViewController.h
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCODE/QrSearchViewController.h"

@interface ScanViewController : QrSearchViewController

//@property (assign, nonatomic) ShowCardViewController* refViewController;

@property (nonatomic, retain) IBOutlet UIImageView *qrCodeView;


@end
