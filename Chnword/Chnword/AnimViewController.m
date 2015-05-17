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
#import "Util.h"

#import "NSObject+JSON.h"
#import "MBProgressHUD.h"


@interface AnimViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) IBOutlet UICollectionView *collectionView;

@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) NSArray *names;
@property (nonatomic, retain) NSArray *cnames;

@end

@implementation AnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBarHidden = YES; 
//    self.navigationController.navigationController.navigationBarHidden = YES;
    
    NSString *opid = [Util generateUuid];
    NSString *userid = @"userid";
    NSString *deviceId = [Util getUdid];
    NSDictionary *param = [NetParamFactory listParam:opid userid:userid device:deviceId page:0 size:0];
    
    [self.hud show:YES];
    
    [NetManager postRequest:URL_LIST param:param success:^(id json){
        
        NSDictionary *dict = [json jsonValue];
        
        NSString *result = [dict objectForKey:@"result"];
        if (result && [result isEqualToString:@"1"]) {
            
            NSDictionary *data = [dict objectForKey:@"data"];
            self.names = [data objectForKey:@"name"];
            self.cnames = [data objectForKey:@"cname"];
            
            [self.collectionView reloadData];
            
            
        }else {
            [self.hud hide:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络参数不对" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
        
    }fail:^ (){
        NSLog(@"fail ");
        
        [self.hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络参数不对" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }];

    
    
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
    return self.names.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnimCollectionViewCell *cell;
    
    cell = (AnimCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"AnimCollectionViewCell" forIndexPath:indexPath];
    
    cell.modleNameLabel.text = [self.names objectAtIndex:indexPath.row];
    
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

#pragma mark - getter
- (MBProgressHUD *) hud
{
    if (_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return _hud;
}

@end
