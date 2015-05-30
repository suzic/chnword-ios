//
//  StoreViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreViewTableViewCell.h"

@interface StoreViewController ()

@property (nonatomic, retain) NSArray *stuffs;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardStart:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardEnd:) name:UIKeyboardDidHideNotification object:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - KeyBoard

- (void) handleKeyBoardStart:(NSNotification *) notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardEndFrame = [aValue CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
    
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    CGRect rect = self.view.frame;
    
    rect.origin.y = - keyboardHeight;
    self.view.frame = rect;
    
}

- (void) handleKeyboardEnd:(NSNotification *) notification
{
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    rect.origin.x = 0;
    self.view.frame = rect;
}


#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stuffs.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreViewTableViewCell *cell;
    
    cell = (StoreViewTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"StoreViewTableViewCell" forIndexPath:indexPath];
    
//    cell.title.text = [self.gameNames objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - getter
- (NSArray *) stuffs
{
    if (!_stuffs) {
        _stuffs = [NSArray arrayWithObjects:@"商品1", @"商品2", @"商品3", @"商品4", nil];
    }
    return _stuffs;
}


/**
 *  购买点击
 */
- (IBAction) buyStuff:(id)sender
{
    
}

/**
 *
 */
- (IBAction) submitCode:(id)sender
{
    
}

/**
 *  隐藏键盘
 */
- (IBAction) hideKeyBoard:(id)sender
{
    if ([self.activeCodeField canResignFirstResponder]) {
        [self.activeCodeField resignFirstResponder];
    }
}


@end
