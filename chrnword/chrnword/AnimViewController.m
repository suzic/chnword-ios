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
@property (nonatomic, assign) NSInteger raw;

@end

@implementation AnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBarHidden = YES; 
//    self.navigationController.navigationController.navigationBarHidden = YES;
    
    self.raw = 0;
    
    NSString *opid = [Util generateUuid];
    NSString *userid = @"userid";
    NSString *deviceId = [Util getUdid];
    NSDictionary *param = [NetParamFactory listParam:opid userid:userid device:deviceId page:0 size:0];
    
    [self.hud show:YES];
    
    NSLog(@"%@", URL_LIST);
    
    [NetManager postRequest:URL_LIST param:param success:^(id json){
        
//        NSDictionary *dict = [json jsonValue];
        NSDictionary *dict = json;
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
    self.raw = indexPath.row;
    [self performSegueWithIdentifier:@"AnimRes" sender:nil];
    
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    if ([@"AnimRes" isEqualToString:identifier]) {
        ResultViewController *controller = (ResultViewController *) segue.destinationViewController;
        controller.names = self.names;
        controller.cnames = self.cnames;
        controller.row = self.raw;
    }
}

#pragma mark - getter
- (MBProgressHUD *) hud
{
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        _hud.color = [UIColor clearColor];//这儿表示无背景
        //显示的文字
        _hud.labelText = @"Test";
        //细节文字
        _hud.detailsLabelText = @"Test detail";
        //是否有庶罩
        _hud.dimBackground = YES;
        [self.navigationController.view addSubview:_hud];
    }
    return _hud;
}

@end
