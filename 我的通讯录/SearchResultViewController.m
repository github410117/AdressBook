//
//  SearchResultViewController.m
//  我的通讯录
//
//  Created by xh on 16/5/22.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "SearchResultViewController.h"
#import "xiangxiViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.definesPresentationContext = YES;
    // Do any additional setup after loading the view.
//    _resultArr = @[@"d",@"g"];
    [self setupTableView];
    NSLog(@"555");
    
}

- (void)setupTableView
{
    _tabView = [[UITableView alloc] init];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    _tabView.delegate = self;
    
    _tabView.dataSource = self;
    
    _tabView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:_tabView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_resultArr.count != 0) {
        return _resultArr.count;
    }
    return _dicc.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (_resultArr.count != 0) {
        cell.textLabel.text = _resultArr[indexPath.row];
        cell.detailTextLabel.text = nil;
    }else{
        NSDictionary *dic = _dicc[indexPath.row];
        NSLog(@"%ld",indexPath.row);
        cell.textLabel.text = dic[@"name"];
        cell.detailTextLabel.text = dic[@"phoneNumber"];
    }
    
    //    FSModel *model = self.resultArr[indexPath.row];
    
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"最佳匹配";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}


/*
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    xiangxiViewController *temp1 = [[xiangxiViewController alloc] init];
    NSDictionary *dic = _dicc[indexPath.row];
    temp1.userName = dic[@"name"];
    temp1.phoneNumber = dic[@"phoneNumber"];
//    NSString *key = _FirstCase[indexPath.section];
//    NSArray *temp1 = _CaseNameDic[key];
//    NSString *str = temp1[indexPath.row];
//    NSLog(@"%@",str);
//    temp.userName = str;
//    temp.phoneNumber = [self findPhoneNumber:str];
//    temp.yinjie = [self wordToYinjie:str];
    //    NSLog(@"%@",[self wordToYinjie:str]);
    //    NSLog(@"%@",[self findPhoneNumber:str]);
    //    NSLog(@"%@",[self wordToYinjie:str]);
    [self.navigationController pushViewController:temp1 animated:YES];
    
}

*/

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
