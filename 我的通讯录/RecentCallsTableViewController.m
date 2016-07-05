//
//  RecentCallsTableViewController.m
//  我的通讯录
//
//  Created by xh on 16/5/20.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "RecentCallsTableViewController.h"

@interface RecentCallsTableViewController ()
{
    NSInteger value;
    UITableView *twoTabView;
    UITableView *threeTabView;
}

@property (nonatomic, strong) NSArray *arrys;
/**
 *  用于存放随机取的数组的元素
 */
@property (nonatomic, strong) NSMutableArray *randomArry;

@end

@implementation RecentCallsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSegment];
    [self arrys];
    twoTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStylePlain];
    twoTabView.delegate = self;
    twoTabView.dataSource = self;
    [self.view addSubview:twoTabView];
    
    threeTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStylePlain];
    threeTabView.delegate = self;
    threeTabView.dataSource = self;
//    twoTabView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden;
    value = (arc4random() % 20) + 1;
    _randomArry = [[NSMutableArray alloc] init];
    [self random];
    NSLog(@"%@",_randomArry);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSArray *)arrys
{
    if (_arrys == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Class.plist" ofType:nil];
        _arrys = [NSArray arrayWithContentsOfFile:path];
    }
    return _arrys;
}

- (void)random
{
    while (_randomArry.count < value) {
        int r = arc4random() % _arrys.count;
        [_randomArry addObject:_arrys[r]];
    }
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self.tableView reloadData];
//}

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
//            [self.view bringSubviewToFront:self.tableView];

        }
            
            break;
        case 2:
        {
//            twoTabView.hidden = NO;
//            self.tableView.hidden = YES;
//            [self.view bringSubviewToFront:twoTabView];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    if ([tableView isEqual:twoTabView]) {
        return 5;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSLog(@"%ld",_randomArry.count);
    if ([tableView isEqual:twoTabView]) {
        return 3;
    }
    return _randomArry.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:twoTabView]) {
        static NSString *identifier1 = @"MyCell1";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
        }
        cell1.textLabel.text = @"ddd";
        return cell1;
    }
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSDictionary *dic =  _randomArry[indexPath.row];
    int i = 0;
    NSMutableArray *arry = [[NSMutableArray alloc] init];
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
        cell.textLabel.textColor = [UIColor redColor];
    }
    cell.textLabel.text = dic[@"name"];
    cell.detailTextLabel.text = dic[@"phoneNumber"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
