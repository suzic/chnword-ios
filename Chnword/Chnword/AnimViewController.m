//
//  AnimViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "AnimViewController.h"
#import "AnimCollectionViewCell.h"
#import "ResultViewController.h"


@interface AnimViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation AnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBarHidden = YES; 
//    self.navigationController.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnimCollectionViewCell *cell;
    
    cell = (AnimCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"AnimCollectionViewCell" forIndexPath:indexPath];
    
    cell.modleNameLabel.text = @"模块";
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    ResultViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
//    [self.navigationController pushViewController:viewController animated:YES];
    
    [self performSegueWithIdentifier:@"AnimRes" sender:nil];
    
}

@end
