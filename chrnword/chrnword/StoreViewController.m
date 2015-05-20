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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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


@end
