//
//  SearchResultViewController.h
//  我的通讯录
//
//  Created by xh on 16/5/22.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) NSArray *resultArr;
@property (nonatomic, strong) NSArray *dicc;

@end
