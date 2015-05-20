//
//  PageViewController.h
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITableView *tableView;

/**
 *  汉字动画点击
 */
- (IBAction) onPageAnim:(id)sender;

/**
 *  汉字扫描点击
 */
- (IBAction) onPageScan:(id)sender;

@end
