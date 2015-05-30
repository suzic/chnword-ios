//
//  PageViewController.m
//  Chnword
//
//  Created by khtc on 15/4/27.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "PageViewController.h"
#import "PageViewTableViewCell.h"

@interface PageViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *gameNames;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gameNames.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PageViewTableViewCell *cell;
    
    cell = (PageViewTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"PageViewTableViewCell" forIndexPath:indexPath];
    
    cell.title.text = [self.gameNames objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter

- (NSArray *) gameNames
{
    if (!_gameNames) {
        _gameNames = [[NSArray alloc] initWithObjects:@"游戏1", @"游戏2", @"游戏3", @"游戏4",
                      @"游戏1", @"游戏2", @"游戏3", @"游戏4",
                      @"游戏1", @"游戏2", @"游戏3", @"游戏4", nil];
    }
    return _gameNames;
}



#pragma mark - UIAction Action Event Handler


/**
 *  汉字动画点击
 */
- (IBAction) onPageAnim:(id)sender
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AnimViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
}

/**
 *  汉字扫描点击
 */
- (IBAction) onPageScan:(id)sender
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ScanViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
}

/**
 *  用来取消选中
 */
- (IBAction) backClicked:(id)sender
{
    if ([self.searchField canResignFirstResponder]) {
        [self.searchField resignFirstResponder];
    }
    
}
@end
