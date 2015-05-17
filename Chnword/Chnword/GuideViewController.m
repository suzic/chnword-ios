//
//  GuideViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController () <UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 3;
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect rect = CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height);
    self.scrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.scrollEnabled = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(screen.bounds.size.width * 3, screen.bounds.size.height);
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    
    
    
    
    float width = self.scrollView.frame.size.width, height = self.scrollView.frame.size.height;
    
    UIImageView *imageView;
    UIButton *button;
    

    
    for (int i = 0; i < 3; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"guide_%d.png", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        
        imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView.frame = CGRectMake(i * width, 0, width, height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
        
        NSLog(@"%@ image : %@", NSStringFromCGRect(imageView.frame), imageName);
    }
    
    
    CGRect buttonRect = CGRectMake( 0, 0, 200, 100);
    button = [[UIButton alloc] initWithFrame:buttonRect];
    button.center = CGPointMake(2.5 * width, height - 100);
    button.backgroundColor = [UIColor greenColor];
    [button setImage:[UIImage imageNamed:@"btn_start.png"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"%@", NSStringFromCGRect(button.frame));
    [self.scrollView addSubview:button];
    
    
    [self.view insertSubview:self.scrollView belowSubview:self.pageControl];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) buttonClicked:(id) sender
{
    [self performSegueWithIdentifier:@"RegisterViewController" sender:nil];
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
    
//    [self.scrollView scrollRectToVisible:rect animated:YES];
    self.scrollView.contentOffset = CGPointMake(i * width, 0);
    
}
#pragma mark - UIScrollViewDelegate
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGRect screen = self.scrollView.frame;
    float width = screen.size.width;
    
    int i = (int)(self.scrollView.contentOffset.x + 1) / width;
    self.pageControl.currentPage = i;
    
    
}
@end
