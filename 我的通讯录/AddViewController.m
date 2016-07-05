//
//  AddViewController.m
//  我的通讯录
//
//  Created by etcxm on 16/5/23.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "AddViewController.h"
#import "cellTableViewCell.h"
#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)

@interface AddViewController ()
{
    UITableView *tabView;
}

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"新建联系人";
    [self setUpTabView];
}


- (void)setUpTabView
{
    tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    tabView.dataSource = self;
    tabView.delegate = self;
    tabView.scrollEnabled = NO;
//    tabView.rowHeight = 100;
    [self.view addSubview:tabView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtn)];
    self.navigationItem.leftBarButtonItem = item;
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneBtn)];
    self.navigationItem.rightBarButtonItem = item1;
    
}

- (void)doneBtn
{
    NSLog(@"ss");
}

- (void)cancelBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifier = @"MyCell";
    cellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[cellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell.photoBtn addTarget:self action:@selector(btnaction) forControlEvents:UIControlEventTouchUpInside];
//    cell.textLabel.text = @"d";
    return cell;
}

- (void)btnaction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *photo = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        }];
        UIAlertAction *cream = [UIAlertAction actionWithTitle:@"选取照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
    [alert addAction:cancel];
    [alert addAction:photo];
    [alert addAction:cream];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
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
