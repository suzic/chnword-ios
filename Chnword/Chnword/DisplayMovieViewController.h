//
//  DisplayMovieViewController.h
//  Chnword
//
//  Created by khtc on 15/5/9.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayMovieViewController : UIViewController

@property (nonatomic, retain) NSString *wordCode;

@property (nonatomic, retain) IBOutlet UIView *gifView;
@property (nonatomic, retain) IBOutlet UIView *videoView;

@end
