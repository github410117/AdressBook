//
//  TaBbarViewController.m
//  我的通讯录
//
//  Created by xh on 16/5/20.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "TaBbarViewController.h"
#import "CollectViewController.h"
#import "RecentCallsTableViewController.h"
#import "DialKeyboardViewController.h"
#import "AdressListViewController.h"
#import "CallsViewController.h"

@interface TaBbarViewController ()

@end

@implementation TaBbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self allItems];
}


/**
 *  TaBBar的4个按钮
 */
- (void)allItems
{
    //收藏页面
    CollectViewController *collect = [[CollectViewController alloc] init];
    UINavigationController *navigationCollect = [[UINavigationController alloc] initWithRootViewController:collect];
    UITabBarItem *collectItem = [[UITabBarItem alloc] initWithTitle:@"个人收藏" image:[UIImage imageNamed:@"star"] selectedImage:[UIImage imageNamed:@"star1"]];
    navigationCollect.tabBarItem = collectItem;
    
    //最近通话
    CallsViewController *recentCalls = [[CallsViewController alloc] init];
    UINavigationController *navigationRecentCalls = [[UINavigationController alloc] initWithRootViewController:recentCalls];
    UITabBarItem *recentCallsItem = [[UITabBarItem alloc] initWithTitle:@"最近通话" image:[UIImage imageNamed:@"clock"] selectedImage:[UIImage imageNamed:@"clock1"]];
    navigationRecentCalls.tabBarItem = recentCallsItem;
    
    //通讯录
    AdressListViewController *adressList = [[AdressListViewController alloc] init];
    UINavigationController *navigationAdressList = [[UINavigationController alloc] initWithRootViewController:adressList];
    UITabBarItem *adressListItem = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:[UIImage imageNamed:@"people"] selectedImage:[UIImage imageNamed:@"people1"]];
    navigationAdressList.navigationBar.barTintColor = [UIColor whiteColor];
    navigationAdressList.navigationBar.alpha = 1;
    
    navigationAdressList.tabBarItem = adressListItem;
    
    //拨号键盘
    DialKeyboardViewController *dialKeyboard = [[DialKeyboardViewController alloc] init];
    UITabBarItem *dialKeyboardItem = [[UITabBarItem alloc] initWithTitle:@"拨号键盘" image:[UIImage imageNamed:@"keyboard"] selectedImage:[UIImage imageNamed:@"keyboard1"]];
    dialKeyboard.tabBarItem = dialKeyboardItem;
    
    //将所有子页面加入数组
    NSArray *AllInterFace = @[navigationCollect,navigationRecentCalls,navigationAdressList,dialKeyboard];
    
    //设置所有页面
    [self setViewControllers:AllInterFace];

    self.selectedIndex = 2;
    
    
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

@end
