//
//  ResultViewController.h
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TesseractOCR.h>

@interface ResultViewController : UIViewController

@property (nonatomic, retain) NSArray *names;
@property (nonatomic, retain) NSArray *cnames;
@property (nonatomic, assign) NSInteger row;


@end
