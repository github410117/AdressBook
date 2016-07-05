//
//  xiangxiViewController.m
//  PinYin4ObjcExample
//
//  Created by xh on 16/5/20.
//  Copyright © 2016年 kimziv. All rights reserved.
//

#import "xiangxiViewController.h"
#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)

@interface xiangxiViewController ()
{
    UITableView *tabView;
}
/**
 *  用来接收懒加载的数据
 */
@property (nonatomic, strong) NSArray *xiangqing;
@end

@implementation xiangxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self editButton];
    [self xiangqing];
    [self tableView1];
    tabView.delegate = self;
    tabView.dataSource = self;
    
    // Do any additional setup after loading the view from its nib.
}

/**
 *  创建一个Tabview
 */
- (void)tableView1
{
    tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStyleGrouped];

    [self.view addSubview:tabView];
}


#pragma mark 委托方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSDictionary *dic = _xiangqing[section];
//    NSLog(@"%d",dic.count);
    return dic.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UILabel *lb;
    UILabel *lb4;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        lb = [[UILabel alloc] init];
        lb4 = [[UILabel alloc] init];
        [cell.contentView addSubview:lb];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
//            lb.font = [UIFont systemFontOfSize:15];
            lb.textColor = [UIColor blackColor];
            lb.frame = CGRectMake(10, 20, 200, 20);
            NSMutableString *temp = [NSMutableString stringWithString:_phoneNumber];
            [temp insertString:@"-" atIndex:3];
            [temp insertString:@"-" atIndex:8];
            lb.text = temp;
            lb4.text = @"移动";
            lb4.font = [UIFont systemFontOfSize:13];
            lb4.textColor = [UIColor colorWithRed:30.0f/255 green:144.0f/255 blue:255.0f/255 alpha:1];
            lb4.frame = CGRectMake(10, 0, 40, 20);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(ScreenW - 50, 10, 40, 40);
            [btn setBackgroundImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame = CGRectMake(ScreenW - 90, 13, 40, 40);
            [btn1 setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
//            UIImageView *image1 = [[UIImageView alloc] init];
//            image1.image = [UIImage imageNamed:@"call"];
//            image1.frame = CGRectMake(220, 10, 40, 40);
            [cell.contentView addSubview:btn1];
            [cell.contentView addSubview:btn];
            [cell.contentView addSubview:lb4];
        }
        else{
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame = CGRectMake(ScreenW - 50, 13, 40, 40);
            [btn1 setBackgroundImage:[UIImage imageNamed:@"facetime"] forState:UIControlStateNormal];
            lb.textColor = [UIColor blackColor];
            lb.frame = CGRectMake(10, 20, 200, 20);
            lb.text = @"FaceTime";
            [cell.contentView addSubview:btn1];
        }
        
    }
    
    NSArray *arrys = @[@"发送信息",@"共享联系人",@"添加到个人收藏"];
    

    if (indexPath.section == 1) {
        lb.text = arrys[indexPath.row];
        lb.font = [UIFont systemFontOfSize:15];
        
        lb.frame = CGRectMake(10, 10, 200, 20);
        lb.textColor = [UIColor colorWithRed:30.0f/255 green:144.0f/255 blue:255.0f/255 alpha:1];
    }
    if (indexPath.section == 2) {
        lb.text = @"阻止此来电号码";
        lb.font = [UIFont systemFontOfSize:15];
        
        lb.frame = CGRectMake(10, 10, 200, 20);
        lb.textColor = [UIColor colorWithRed:30.0f/255 green:144.0f/255 blue:255.0f/255 alpha:1];
    }
    
    
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%ld",_xiangqing.count);
    return _xiangqing.count;
}
/**
 *  右边的编辑按钮
 */
- (void)editButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)xiangqing
{
    if (_xiangqing == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"xiangqing.plist" ofType:nil];
        _xiangqing = [NSArray arrayWithContentsOfFile:path];
    }
    return _xiangqing;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectZero];
        view1.backgroundColor = [UIColor whiteColor];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 200, 50)];
        lb.font = [UIFont boldSystemFontOfSize:20];
        UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(8, 32, 200, 30)];
        lb.text = _userName;
        lb1.text = _yinjie;
        [view1 addSubview:lb1];
        [view1 addSubview:lb];
        return view1;
    }
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectZero];
    return view2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return 100;
    }else if (section == 1){
        return 50;
    }else{
        return 40;
    }
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
