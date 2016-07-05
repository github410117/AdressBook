//
//  xiangxiViewController.h
//  PinYin4ObjcExample
//
//  Created by xh on 16/5/20.
//  Copyright © 2016年 kimziv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xiangxiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *yinjie;

@end
