//
//  CallsViewController.m
//  我的通讯录
//
//  Created by etcxm on 16/5/24.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "CallsViewController.h"

@interface CallsViewController ()
{
    NSInteger value;
    UITableView *twoTabView;
    UITableView *threeTabView;
}

@property (nonatomic, strong) NSMutableArray *tempNumber;

@property (nonatomic, strong) NSArray *arrys;
/**
 *  用于存放随机取的数组的元素
 */
@property (nonatomic, strong) NSMutableArray *randomArry;
@end

@implementation CallsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSegment];
    [self arrys];
    _tempNumber = [[NSMutableArray alloc] init];
    twoTabView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    twoTabView.delegate = self;
    twoTabView.dataSource = self;
    [self.view addSubview:twoTabView];
    
    threeTabView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    threeTabView.delegate = self;
    threeTabView.dataSource = self;
    [self.view addSubview:threeTabView];
    [self.view bringSubviewToFront:twoTabView];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
   
    value = (arc4random() % 20) + 1;
    _randomArry = [[NSMutableArray alloc] init];
    [self random];
    NSLog(@"%@",_randomArry);
    
}

- (void)random
{
    while (_randomArry.count < value) {
        int r = arc4random() % _arrys.count;
        [_randomArry addObject:_arrys[r]];
    }
}

- (NSArray *)arrys
{
    if (_arrys == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Class.plist" ofType:nil];
        _arrys = [NSArray arrayWithContentsOfFile:path];
    }
    return _arrys;
}

- (void)setSegment
{
    NSArray *arry = @[@"所有通话",@"未接来电"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:arry];
    CGRect frame = segment.frame;
    frame.size = CGSizeMake(150, 30);
    segment.frame = frame;
    CGPoint cen = segment.center;
    cen.x = 375/2;
    cen.y = self.view.frame.size.height / 2;
    segment.center = cen;
    segment.selectedSegmentIndex = 0;
    segment.momentary = NO;
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationItem setTitleView:segment];
    
    
}


- (void)segmentAction:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex + 1;
    NSLog(@"%ld",index);
    switch (index) {
        case 1:
        {
            //            twoTabView.hidden = ;
            //            self.tableView.hidden = NO;
                        [self.view bringSubviewToFront:twoTabView];
            
        }
            
            break;
        case 2:
        {
            //            twoTabView.hidden = NO;
            //            self.tableView.hidden = YES;
                        [self.view bringSubviewToFront:threeTabView];
            
        }
            break;
            
        default:
            break;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    if ([tableView isEqual:threeTabView]) {
        return 1;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSLog(@"%ld",_randomArry.count);
    if ([tableView isEqual:threeTabView]) {
        return _tempNumber.count;
    }
    return _randomArry.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:threeTabView]) {
        static NSString *identifier1 = @"MyCell1";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
        }
        NSString *str = _tempNumber[indexPath.row];
        NSInteger  j = [str integerValue];
        NSDictionary *dic = _randomArry[j];
        cell1.textLabel.textColor = [UIColor redColor];
        cell1.textLabel.text = dic[@"name"];
        cell1.detailTextLabel.text = dic[@"phoneNumber"];
        return cell1;
    }
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSDictionary *dic =  _randomArry[indexPath.row];
    //    while (i < 3) {
    //        NSInteger j = arc4random() % _randomArry.count;
    //        NSString *str = [NSString stringWithFormat:@"%ld",j];
    //        [arry addObject:str];
    //    }
    //
    //    for (NSString *str1 in arry) {
    //        <#statements#>
    //    }
    
    if (indexPath.row == (arc4random() % _randomArry.count) || indexPath.row == (arc4random() % _randomArry.count) ) {
        NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row];
        [_tempNumber addObject:str];
        
        cell.textLabel.textColor = [UIColor redColor];
    }
    cell.textLabel.text = dic[@"name"];
    cell.detailTextLabel.text = dic[@"phoneNumber"];
    
    return cell;
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
