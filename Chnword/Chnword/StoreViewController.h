//
//  StoreViewController.h
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController

//激活码
@property (nonatomic, retain) IBOutlet UITextField *activeCodeField;

/**
 *  购买点击
 */
- (IBAction) buyStuff:(id)sender;

/**
 *
 */
- (IBAction) submitCode:(id)sender;

/**
 *  隐藏键盘
 */
- (IBAction) hideKeyBoard:(id)sender;
@end
