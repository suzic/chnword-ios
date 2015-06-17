//
//  WordViewController.h
//  Chnword
//
//  Created by khtc on 15/6/16.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIView *moduleView;
@property (nonatomic, retain) IBOutlet UIView *wordView;

@property (nonatomic, retain) IBOutlet UITableView *moduleTableView;
@property (nonatomic, retain) IBOutlet UITableView *wordTableView;
@property (nonatomic, retain) IBOutlet UICollectionView *wordCollectionView;





@end
