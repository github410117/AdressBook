//
//  AdressListViewController.m
//  我的通讯录
//
//  Created by xh on 16/5/20.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "AdressListViewController.h"
#import "xiangxiViewController.h"
#import "SearchResultViewController.h"
#import "AddViewController.h"
#define ScreenX ([UIScreen mainScreen].bounds.origin.x)
#define ScreenY ([UIScreen mainScreen].bounds.origin.y)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)
#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#import "PinYin4Objc.h"

@interface AdressListViewController ()
{
    UITableView *tabView;
    UISearchController *searchCtr;
    UIView *view1;
}
@property (nonatomic, strong) NSMutableArray *diccarry;
//@property (nonatomic, strong) NSMutableDictionary *tempDic;

/**
 *  用于给结果界面赋值
 */
@property (nonatomic, strong) NSMutableArray *temp;

/**
 *  用于判断是否是过滤
 */
@property (nonatomic, assign) BOOL isFiltered;

/**
 *  用于搜索框查询的数组
 */
@property (nonatomic, strong) NSMutableArray *SearchArry;

/**
 *  用于接收plist文件数据
 */
@property (nonatomic, strong) NSArray *AllClass;
/**
 *  用于存放首字母
 */
@property (nonatomic, strong) NSMutableArray *FirstCase;
/**
 *  用于存放字母对应的名字
 */
@property (nonatomic, strong) NSMutableDictionary *CaseNameDic;

@end

@implementation AdressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _temp = [[NSMutableArray alloc] init];
//    _tempDic = [[NSMutableDictionary alloc] init];
    _diccarry = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    self.title = @"所有联系人";
    [self setUpTabView];
    tabView.delegate = self;
    tabView.dataSource = self;
//    [self headerView];
    [self searchBar];
    [self AllClass];
    [self leftAndRightItem];
    [self wordToPinyin:_AllClass];
    [self firstCaseCorrespondingName];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [tabView.tableHeaderView bringSubviewToFront:tabView];
    NSLog(@"%@",_CaseNameDic);
    
    
}

/**
 *  一个字母对应多个名字
 */
- (void)firstCaseCorrespondingName
{
    HanyuPinyinOutputFormat *outformat = [[HanyuPinyinOutputFormat alloc] init];
    [outformat setToneType:ToneTypeWithoutTone];
    [outformat setVCharType:VCharTypeWithV];
    [outformat setCaseType:CaseTypeUppercase];
    _CaseNameDic = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < _FirstCase.count; i ++) {
        NSMutableArray *arry = [[NSMutableArray alloc] init];
        NSString *firstCase = _FirstCase[i];
        for (int j = 0; j < _AllClass.count; j ++) {
            NSDictionary *dic = _AllClass[j];
            NSString *name = dic[@"name"];
            NSString *str = [PinyinHelper toHanyuPinyinStringWithNSString:name withHanyuPinyinOutputFormat:outformat withNSString:@" "];
            NSRange range = {0,1};
            NSString *firstCase1 = [str substringWithRange:range];
            if ([firstCase isEqualToString:firstCase1]) {
                [arry addObject:name];
            }
        }
        [_CaseNameDic setObject:arry forKey:firstCase];
    }
}


/**
 *  将plist文件转为数组，并将名字转换为字母获取第一个，并且去重复，排序
 *
 *  @param arry 传入plist文件懒加载进来的数组
 */
- (void)wordToPinyin:(NSArray *)arry
{
    HanyuPinyinOutputFormat *outformat = [[HanyuPinyinOutputFormat alloc] init];
    [outformat setToneType:ToneTypeWithoutTone];
    [outformat setVCharType:VCharTypeWithV];
    [outformat setCaseType:CaseTypeUppercase];
    _FirstCase = [NSMutableArray array];
    for (int i = 0; i <arry.count; i ++) {
        NSDictionary *dic = arry[i];
        NSString *name = dic[@"name"];
        NSString *str = [PinyinHelper toHanyuPinyinStringWithNSString:name withHanyuPinyinOutputFormat:outformat withNSString:@" "];
        NSRange range = {0,1};
        NSString *firstCase = [str substringWithRange:range];
        [_FirstCase addObject:firstCase];
    }
    //去重复
    NSSet *set = [NSSet setWithArray:_FirstCase];
    _FirstCase = (NSMutableArray *)[set allObjects];
    //排序
    _FirstCase = (NSMutableArray *)[(NSArray *)_FirstCase sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
}

/**
 *  懒加载plist文件数据
 */
- (NSArray *)AllClass
{
    if (_AllClass == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Class.plist" ofType:nil];
        _AllClass = [NSArray arrayWithContentsOfFile:path];
    }
    return _AllClass;
}


/**
 *  创建Tabview,并设置委托、属性等
 */
- (void)setUpTabView
{
    tabView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenX, ScreenY+ 40, ScreenW, ScreenH - 152) style:UITableViewStylePlain];
    //设置数据源和委托代理
    
    
    [self.view addSubview:tabView];
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"d";
//}




#pragma mark 数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
//    if (section == 0) {
//        return 1;
//    }
    NSString *str = _FirstCase[section];
    NSArray *arry =  _CaseNameDic[str];
    return arry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *str = _FirstCase[indexPath.section];
    NSArray *arry = _CaseNameDic[str];
    cell.textLabel.text = arry[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _FirstCase.count;
}

#pragma mark 自定义view
/**
 *  自定义headerView
 */
//注意注意再注意，这里header和footer一定要分清
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    headerView.backgroundColor = [UIColor colorWithRed:245.0f/255 green:245.0f/255 blue:245.0f/255 alpha:1];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, -5, ScreenW, 40)];
    headerLabel.text = _FirstCase[section];
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    [headerView addSubview:headerLabel];
    return headerView;
}


#pragma mark 导航栏左右2边的Item
/**
 *  左右2边的Item
 */
- (void)leftAndRightItem
{
    //右边的+按钮
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPeople)];
    self.navigationItem.rightBarButtonItem = add;
    
    //左边的群组按钮
    UIBarButtonItem *group = [[UIBarButtonItem alloc] initWithTitle:@"群组" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = group;
}

- (void)addPeople
{
    AddViewController *add = [[AddViewController alloc] init];
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:add];
    [self presentViewController:na  animated:YES completion:nil];
}

/**
 *  右边的索引字母
 */
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _FirstCase;
}

#warning 不写下面这个，也可以实现索引跳转，不知道原因
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    // 获取所点目录对应的indexPath值
//    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
//    
//    // 让table滚动到对应的indexPath位置
//    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    
//    return index;
//}

/**
 *  根据名字查电话号码
 */
- (NSString *)findPhoneNumber:(NSString *)name
{
    for (int i = 0; i < _AllClass.count; i ++) {
        NSDictionary *dic = _AllClass[i];
        NSString *str = dic[@"name"];
        if ([str isEqualToString:name]) {
            return dic[@"phoneNumber"];
        }
    }
    return @"无";
}




/**
 *  名字转音节
 */
- (NSString *)wordToYinjie:(NSString *)word
{
    CFStringRef test = (__bridge CFStringRef)word;
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, test);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    return (__bridge NSString *)(string);
}

//选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    xiangxiViewController *temp = [[xiangxiViewController alloc] init];
    NSString *key = _FirstCase[indexPath.section];
    NSArray *temp1 = _CaseNameDic[key];
    NSString *str = temp1[indexPath.row];
    NSLog(@"%@",str);
    temp.userName = str;
    temp.phoneNumber = [self findPhoneNumber:str];
    temp.yinjie = [self wordToYinjie:str];
    //    NSLog(@"%@",[self wordToYinjie:str]);
    //    NSLog(@"%@",[self findPhoneNumber:str]);
    //    NSLog(@"%@",[self wordToYinjie:str]);
    [self.navigationController pushViewController:temp animated:YES];
}

/**
 *  头view
 */
//- (void)headerView
//{
//    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 90)];
//    view1.backgroundColor = [UIColor whiteColor];
//    UILabel *lb = [[UILabel alloc] init];
//    lb.text = @"本机号码:   +86 181-1340-0487";
//    lb.font = [UIFont systemFontOfSize:13];
//    lb.frame = CGRectMake(70, 40, 200, 20);
//    UILabel *lb1 = [[UILabel alloc] init];
//    lb1.text = @"谢航";
//    lb1.font = [UIFont systemFontOfSize:18];
//    lb1.frame = CGRectMake(70, 10, 100, 40);
//    [view1 addSubview:lb1];
//    [view1 addSubview:lb];
//    tabView.tableHeaderView = view1;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

#pragma mark 搜索栏，使用的是UISearchController而不是SearchBar
- (void)searchBar
{
    SearchResultViewController *searchResult = [[SearchResultViewController alloc] init];
    
//    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:searchResult];
//    na.navigationBar.hidden = YES;
    
    searchCtr = [[UISearchController alloc] initWithSearchResultsController:searchResult];
    searchCtr.searchResultsUpdater = self;
    searchCtr.searchBar.frame = CGRectMake(0, 0, 375, 40);
    searchCtr.searchBar.placeholder = @"搜索";
    [searchCtr.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
//    tabView.tableHeaderView = searchCtr.searchBar;
//    [searchCtr setEdgesForExtendedLayout:UIRectEdgeNone];
    [self.view addSubview:searchCtr.searchBar];
}
//与UISearchController配套的方法，
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (_SearchArry.count != 0) {
        [_SearchArry removeAllObjects];
    }
    
//    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS '%@'",searchCtr.searchBar.text];
    
//    SearchResultViewController *searchResult = (SearchResultViewController *)searchCtr.searchResultsController;
//    SearchResultViewController *searchResult = [[SearchResultViewController alloc] init];
    
//    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:searchResult];
    
    SearchResultViewController *searchResult = (SearchResultViewController *)searchCtr.searchResultsController;
//    na.navigationBar.hidden = YES;
//    SearchResultViewController *searchResult1 = [[SearchResultViewController alloc] init];
    
    
//    UINavigationController *nagivationa = [[UINavigationController alloc] initWithRootViewController:searchResult];
    
    if ([searchCtr.searchBar.text integerValue] == 0) {
        [self wordToPinyin2:searchCtr.searchBar.text];
        searchResult.resultArr = _temp;
        
    }else{
        [self numberToName:searchCtr.searchBar.text];
        searchResult.dicc = _diccarry;
    }
    
//    _SearchArry = (NSMutableArray *)[_temp filteredArrayUsingPredicate:searchPredicate];
    
    
    //这里的searchResult和上面的是同一个地址

    
    
    
    [searchResult.tabView reloadData];
//    [searchCtr.searchResultsController reloadData];
}
//- (void)ClickAction
//{
//    
//}

/**
 *  根据号码查名字
 */
//- (NSString *)findNameFromPhoneNumber:(NSInteger)PhoneNumber
//{
//    NSString *pn = [NSString stringWithFormat:@"%ld",PhoneNumber];
//    for (int i = 0 ; i < _AllClass.count; i ++) {
//        NSDictionary *dic = _AllClass[i];
//        NSString *str = dic[@"phoneNumber"];
//        if ([str isEqualToString:pn]) {
//            return dic[@"name"];
//        }
//    }
//    return nil;
//}

- (void)numberToName:(NSString *)number
{
//    if (_tempDic.count != 0) {
//        [_tempDic removeAllObjects];
//    }
    if (_diccarry.count != 0) {
        [_diccarry removeAllObjects];
    }
    for (int i = 0; i < _AllClass.count; i ++) {
         NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        NSDictionary *dic = _AllClass[i];
        NSString *str = dic[@"phoneNumber"];
        if ([str rangeOfString:number].location != NSNotFound) {
           
            [tempDic setObject:str forKey:@"phoneNumber"];
            [tempDic setObject:dic[@"name"] forKey:@"name"];
        }
        if (tempDic.count != 0) {
            [_diccarry addObject:tempDic];
        }
        
    }
}




- (void)wordToPinyin2:(NSString *)Case
{
    
    if (_temp.count != 0) {
        [_temp removeAllObjects];
    }
    HanyuPinyinOutputFormat *outformat = [[HanyuPinyinOutputFormat alloc] init];
    [outformat setToneType:ToneTypeWithoutTone];
    [outformat setVCharType:VCharTypeWithV];
    [outformat setCaseType:CaseTypeUppercase];
    if ([self isValidateHomePhoneNum:Case]) {
        if (Case.length == 1) {
            NSArray *arrys = _CaseNameDic[Case];
            if (arrys.count == 0) {
                return;
            }
            if (Case.length == 0) {
                return;
            }
            if (Case.length == 1) {
                for (int z = 0; z < arrys.count; z ++) {
                    NSString *name1 = arrys[z];
                    [_temp addObject:name1];
                }
                return;
            }
        }
    }
    
    
    
    for (int i = 0; i <_AllClass.count; i ++) {
        NSDictionary *dic = _AllClass[i];
        NSString *name = dic[@"name"];
        NSString *str = [PinyinHelper toHanyuPinyinStringWithNSString:name withHanyuPinyinOutputFormat:outformat withNSString:@""];
                NSString *str1 = [PinyinHelper toHanyuPinyinStringWithNSString:name withHanyuPinyinOutputFormat:outformat withNSString:@"-"];
        NSArray *arry = [str1 componentsSeparatedByString:@"-"];
        NSMutableString *all = [[NSMutableString alloc] init];
        for (int j = 0; j < arry.count; j ++) {
            NSString *str1 = arry[j];
            NSString *first = [str1 substringToIndex:1];
            [all appendString:first];
        }
//        if (Case.length == 0) {
//            return;
//        }
//        NSString *str2 = [Case substringToIndex:1];
//
//        NSArray *arrys = _CaseNameDic[str2];
//        if (arrys.count == 0) {
//            return;
//        }
//        if (Case.length == 1) {
//            for (int z = 0; z < arrys.count; z ++) {
//                NSString *name1 = arrys[z];
//                [_temp addObject:name1];
//            }
//        }else
        if ([str rangeOfString:Case options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [_temp addObject:name];
        }
        else if([all rangeOfString:Case options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [_temp addObject:name];
        }else if ([name rangeOfString:Case].location != NSNotFound) {
            [_temp addObject:name];
        }
//        NSString *none = @"无";
//        [_temp addObject:none];
//        if([str2 rangeOfString:Case options:NSCaseInsensitiveSearch].location != NSNotFound){
//            [_temp addObject:name];
//        }
//        else if ([all rangeOfString:Case options:NSCaseInsensitiveSearch].location != NSNotFound) {
//            [_temp addObject:name];
//        }
//        else if([str rangeOfString:Case options:NSCaseInsensitiveSearch].location != NSNotFound) {
//            [_temp addObject:name];
//        }else if ([name rangeOfString:Case].location != NSNotFound) {
//            [_temp addObject:name];
//        }
        
//        NSString *firstCase = [str substringWithRange:range];
//        if ([firstCase isEqualToString:Case]) {
//            [_temp addObject:name];
//        }
//        [_FirstCase addObject:firstCase];
    }
//    NSSet *set = [NSSet setWithArray:_temp];
//    _temp = (NSMutableArray *)[set allObjects];
}


- (BOOL)isValidateHomePhoneNum:(NSString *)phoneNum
{
    // 只需要不是中文即可
    NSString *regex = @".{0,}[\u4E00-\u9FA5].{0,}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self matches %@",regex];
    BOOL res = [predicate evaluateWithObject:phoneNum];
    if (res == TRUE) {
        //有中文
        return FALSE;
    }
    else
    {
        //无中文
        return TRUE;
    }
}






/*
#pragma mark 搜索栏的代理方法
//搜索栏中文字有变动时触发
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        _isFiltered = NO;
        [searchBar resignFirstResponder];
    }else{
        _isFiltered = YES;
        _SearchArry = [[NSMutableArray alloc] init];
        for (NSString *str in [_CaseNameDic allKeys]) {
            if ([str rangeOfString:searchText].location != NSNotFound) {
                NSArray *arry = [[NSArray alloc] init];
                arry = _CaseNameDic[str];
                [_SearchArry addObject:arry];
            }
        }
    }
    [tabView reloadData];
}
*/
/*
 
 NSString *str = _FirstCase[indexPath.section];
 NSArray *arry = _CaseNameDic[str];
 cell.textLabel.text = arry[indexPath.row];
 
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
