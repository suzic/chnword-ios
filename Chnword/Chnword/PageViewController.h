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

@property (nonatomic, retain) IBOutlet UITextField *searchField;

/**
 *  汉字动画点击
 */
- (IBAction) onPageAnim:(id)sender;

/**
 *  汉字扫描点击
 */
- (IBAction) onPageScan:(id)sender;


/**
 *  用来取消选中
 */
- (IBAction) backClicked:(id)sender;


@end
