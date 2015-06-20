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

#import "ModuleCell.h"
#import "WordCell.h"

#import "Module.h"
#import "Word.h"

#import "Util.h"

@interface WordViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) MBProgressHUD *hud;

@property (nonatomic, retain) NSMutableArray *modules;
@property (nonatomic, retain) NSMutableArray *words;


@end


@implementation WordViewController



- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self showModule];
    
    //请求modules
    [self requestModules];
    
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
    
    return self.modules.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModuleCell *cell = nil;
    Module *module = [self.modules objectAtIndex:indexPath.row];
    if (tableView == self.moduleTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ModuleCell" forIndexPath:indexPath];
        
        cell.moduleNameLable.text = module.moduleName;
//        cell.lockStateLabel.text = module.moduleCode;
        cell.lockStateLabel.text = @"";
        
    } else if (tableView == self.wordTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ModuleCell" forIndexPath:indexPath];
        
        cell.moduleNameLable.text = module.moduleName;
        //        cell.lockStateLabel.text = module.moduleCode;
        cell.lockStateLabel.text = @"";
        
    }
    
    return cell;
}

#pragma mark - table delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.moduleTableView) {
        
        [self showWord:[self.modules objectAtIndex:indexPath.row]];
        [self.wordTableView reloadData];
        
    } else if (tableView == self.wordTableView) {
        
        //request net
        [self requestWord:[self.modules objectAtIndex:indexPath.row]];
//        [self.wordCollectionView reloadData];
        
    }
    
}

#pragma mark - collection view data source

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.words.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WordCell" forIndexPath:indexPath];
    Word *word = [self.words objectAtIndex:indexPath.row];
    cell.wordLabel.text = word.wordName;
    return cell;
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
            NSArray *array = [dict objectForKey:@"name"];
            NSArray *carray = [data objectForKey:@"cname"];
            if (data && array) {
                [self.modules removeAllObjects];
                Module *module = nil;
                for (NSInteger i = 0; i < array.count ; i ++) {
                    
                    module = [[Module alloc] init];
                    module.moduleName = [array objectAtIndex:i];
                    module.moduleCode = [carray objectAtIndex:i];
                    
                    [self.modules addObject:module];
                }
                [self.moduleTableView reloadData];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无参数" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
            
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
            NSArray *wArray = [data objectForKey:@"word"];
            NSArray *wCode  = [data objectForKey:@"unicode"];
            
            if (data && wArray && wCode) {
                [self.words removeAllObjects];
                for (NSInteger i = 0; i < wArray.count; i ++) {
                    Word *word = [[Word alloc] init];
                    word.wordName = [wArray objectAtIndex:i];
                    word.wordCode = [wCode  objectAtIndex:i];
                    [self.words addObject:word];
                }
                [self.wordCollectionView reloadData];
                
                
            } else  {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无参数返回" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
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

#pragma mark - UIAction Event Handler
/**
 *  scan 点击
 */
- (IBAction) onScanButtonClicked:(id)sender
{
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScanViewController"];
    [self.navigationController pushViewController: controller animated:YES];
}

/**
 *  用户 点击
 */
- (IBAction) onUserButtonClicked:(id)sender
{
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"UserViewController"];
    [self presentViewController:controller animated:YES completion:^{
        
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
- (NSMutableArray *) modules {
    if (!_modules) {
        _modules = [NSMutableArray array];
    }
    return _modules;
}
- (NSMutableArray *) words {
    if (!_words) {
        _words = [NSMutableArray array];
    }
    return _words;
}

@end
