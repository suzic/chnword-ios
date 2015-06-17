//
//  WordViewController.m
//  Chnword
//
//  Created by khtc on 15/6/16.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "WordViewController.h"
#import "Module.h"
#import "MBProgressHUD.h"

#import "Util.h"

@interface WordViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) MBProgressHUD *hud;

@property (nonatomic, retain) NSArray *modules;
@property (nonatomic, retain) NSArray *words;


@end


@implementation WordViewController



- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self showModule];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}


#pragma mark - table data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.moduleTableView) {
        
    } else if (tableView == self.wordTableView) {
        
        
    }
    
    return nil;
}

#pragma mark - table delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.moduleTableView) {
        
    } else if (tableView == self.wordTableView) {
        
        
    }
    
}

#pragma mark - collection view data source

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}






#pragma mark - 业务逻辑


- (void) showModule {
    
    self.moduleView.hidden = NO;
    self.wordView.hidden = YES;
    
}

- (void) showWord:(Module *) module
{
    self.moduleView.hidden = YES;
    self.wordView.hidden = NO;
    
    
}



- (void) requestModules {
    
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
        [self.hud hide:YES];
        
        if (result && [result isEqualToString:@"1"]) {
            
            NSDictionary *data = [dict objectForKey:@"data"];
            NSArray *array = [dict objectForKey:@""];
            if (data) {
                
            }
            
            
        }else {
            
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

- (void) requestWord:(Module *) module {
    
    NSString *opid = [Util generateUuid];
    NSString *userid = @"userid";
    NSString *deviceId = [Util getUdid];
    
    NSString *str = module.moduleCode;
    
    NSDictionary *param = [NetParamFactory subListParam:opid userid:userid device:deviceId zone:str page:0 size:0];
    
    
    [self.hud show:YES];
    
    NSLog(@"%@", URL_SUBLIST);
    
    [NetManager postRequest:URL_SUBLIST param:param success:^(id json){
        
        //        NSDictionary *dict = [json jsonValue];
        NSDictionary *dict = json;
        NSString *result = [dict objectForKey:@"result"];
        [self.hud hide:YES];
        if (result && [result isEqualToString:@"1"]) {
            
            NSDictionary *data = [dict objectForKey:@"data"];
            
            if (data != NULL) {
                //                self.wordNames = [data objectForKey:@"word_name"];
                //                self.wordIndexs = [data objectForKey:@"word_index"];
//                self.wordNames = [data objectForKey:@"word"];
//                self.wordIndexs = [data objectForKey:@"unicode"];
                
            } else  {
                [self.hud hide:YES];
            }
            
//            [self.collectionView reloadData];
            
            
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


#pragma mark -getter

- (MBProgressHUD *) hud {
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
