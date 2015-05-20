//
//  ResultViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "ResultViewController.h"
#import "ModelTableViewCell.h"
#import "FontCollectionViewCell.h"
#import "MBProgressHUD.h"
#import "Util.h"
#import "DisplayMovieViewController.h"

@interface ResultViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) IBOutlet UICollectionView *collectionView;

@property (nonatomic, retain) MBProgressHUD *hud;

@property (nonatomic, retain) NSArray *wordNames;
@property (nonatomic, retain) NSArray *wordIndexs;
@property (nonatomic, retain) NSString *currentWordCode;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self getData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getData
{
    NSString *opid = [Util generateUuid];
    NSString *userid = @"userid";
    NSString *deviceId = [Util getUdid];
    
    NSString *str = [self.cnames objectAtIndex:self.row];
    
    NSDictionary *param = [NetParamFactory subListParam:opid userid:userid device:deviceId zone:str page:0 size:0];
    
    
    [self.hud show:YES];
    
    NSLog(@"%@", URL_SUBLIST);
    
    [NetManager postRequest:URL_SUBLIST param:param success:^(id json){
        
        //        NSDictionary *dict = [json jsonValue];
        NSDictionary *dict = json;
        NSString *result = [dict objectForKey:@"result"];
        if (result && [result isEqualToString:@"1"]) {
            
            NSDictionary *data = [dict objectForKey:@"data"];
            
            self.wordNames = [data objectForKey:@"word_name"];
            self.wordIndexs = [data objectForKey:@"word_index"];
            
            
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

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.names.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModelTableViewCell *cell;
    
    cell = (ModelTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"ModelTableViewCell" forIndexPath:indexPath];
    
    cell.modelName.text = [self.names objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.wordNames.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FontCollectionViewCell *cell;
    
    cell = (FontCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"FontCollectionViewCell" forIndexPath:indexPath];
    
    cell.fontLabel.text = [self.wordNames objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    self.currentWordCode = [self.wordIndexs objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"DisplayMovie" sender:nil];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    if ([@"DisplayMovie" isEqualToString:identifier]) {
        DisplayMovieViewController *controller = (DisplayMovieViewController *) segue.destinationViewController;
        
        controller.wordCode = self.currentWordCode;
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
