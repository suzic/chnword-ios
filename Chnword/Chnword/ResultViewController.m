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
#import <MediaPlayer/MediaPlayer.h>
#import "DataUtil.h"

@interface ResultViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) IBOutlet UICollectionView *collectionView;

@property (nonatomic, retain) MBProgressHUD *hud;

@property (nonatomic, retain) NSArray *wordNames;
@property (nonatomic, retain) NSArray *wordIndexs;
@property (nonatomic, retain) NSString *currentWordCode;

@property (nonatomic, retain) MPMoviePlayerController *mediaPlayer;

@property (nonatomic, retain) NSArray *unlocked_models;

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
        [self.hud hide:YES];
        if (result && [result isEqualToString:@"1"]) {
            
            NSDictionary *data = [dict objectForKey:@"data"];
            
            if (data != NULL) {
//                self.wordNames = [data objectForKey:@"word_name"];
//                self.wordIndexs = [data objectForKey:@"word_index"];
                self.wordNames = [data objectForKey:@"word"];
                self.wordIndexs = [data objectForKey:@"unicode"];

            } else  {
                [self.hud hide:YES];
            }
            
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
    NSString *str = [self.cnames objectAtIndex:indexPath.row];

    
    if (![DataUtil isUnlockAllForUser:[DataUtil getDefaultUser]]  && ![DataUtil isContain:self.unlocked_models object:str]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未解说" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    }
    
    
    NSString *opid = [Util generateUuid];
    NSString *userid = @"userid";
    NSString *deviceId = [Util getUdid];
    
    self.row = indexPath.row;
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
                self.wordNames = [data objectForKey:@"word"];
                self.wordIndexs = [data objectForKey:@"unicode"];
                
            } else  {
                [self.hud hide:YES];
            }
            
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
    
    
    DisplayMovieViewController *disControler = [self.storyboard instantiateViewControllerWithIdentifier:@"DisplayMovieViewController"];
    [self.navigationController pushViewController:disControler animated:YES];
    return;
    
    
//    self.currentWordCode = [self.wordIndexs objectAtIndex:indexPath.row];
//    [self performSegueWithIdentifier:@"DisplayMovie" sender:nil];
    
    
//    NSString *url = @"http://app.3000zi.com/api/word.php";
//    NSDictionary *param = [NetParamFactory wordParam:opid userid:userid device:deviceId word:@"王"];
    NSDictionary *param = [NetParamFactory wordParam:[Util generateUuid] userid:@"1" device:@"1" word:@"1"];
    
    [self.hud show:YES];
    [NetManager postRequest:URL_SHOW param:param success:^(id json){
        
        NSLog(@"success with json: %@", json);
        NSDictionary *dict = json;
        
        [self.hud hide:YES];
        
        if (dict) {
            NSString *result = [dict objectForKey:@"result"];
            
            if ([result isEqualToString:@"1"]) {
                NSDictionary *data = [dict objectForKey:@"data"];
                
                NSString *videoUrl = [data objectForKey:@"video"];
                NSString *gifUrl = [data objectForKey:@"gif"];
//                self.mediaPlayer.contentURL = [NSURL URLWithString:videoUrl];
//                [self.mediaPlayer play];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:videoUrl delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];

            }else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
            
        } else {
            [self.hud hide:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
    }fail:^ (){
        NSLog(@"fail ");
        [self.hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];

    
    
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

- (MPMoviePlayerController *) mediaPlayer
{
    if (!_mediaPlayer) {
        _mediaPlayer = [[MPMoviePlayerController alloc] init];
        _mediaPlayer.controlStyle = MPMovieControlStyleFullscreen;
        [_mediaPlayer.view setFrame:self.view.bounds];
        _mediaPlayer.initialPlaybackTime = -1;
        [self.view addSubview:_mediaPlayer.view];
        // 注册一个播放结束的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myMovieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:_mediaPlayer];
    }
    return _mediaPlayer;
}


#pragma mark -------------------视频播放结束委托--------------------

/*
 @method 当视频播放完毕释放对象
 */
-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    //视频播放对象
    MPMoviePlayerController* theMovie = [notify object];
    //销毁播放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    [theMovie.view removeFromSuperview];
    // 释放视频对象
}


#pragma mark - Getter
- (NSArray *) unlocked_models
{
    if (!_unlocked_models) {
        _unlocked_models = [DataUtil getUnlockModel:[DataUtil getDefaultUser]];
    }
    return _unlocked_models;
}

@end
