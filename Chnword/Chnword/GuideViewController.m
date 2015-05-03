//
//  GuideViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 4;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIImageView *imageView;
    UIButton *button;
    float width = self.scrollView.frame.size.width, height = self.scrollView.frame.size.height;

    for (int i = 0; i < 4; i ++) {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaohei_big.jpg"]];
        imageView.frame = CGRectMake(i * width, 0, width, height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
    }
    
    CGRect rect = CGRectMake( 3 * width + width/2 - 20, height - 50, 40, 40);
    button = [[UIButton alloc] initWithFrame:rect];
    button.titleLabel.text = @"开始旅程";
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) buttonClicked:(id) sender
{
    [self.view removeFromSuperview];
}

/**
 *  page control 值改变的控制方法
 */
- (IBAction) pageControlValueChanded:(id)sender
{
    NSInteger i = self.pageControl.currentPage;
    CGRect screen = self.scrollView.frame;
    float width = screen.size.width;
    float height = screen.size.height;
    
    CGRect rect = CGRectMake(i * width, 0, width, height);
    
    [self.scrollView scrollRectToVisible:rect animated:YES];
    
}

@end
