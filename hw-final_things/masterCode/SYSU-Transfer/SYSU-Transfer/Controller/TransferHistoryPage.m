//
//  TransferHistoryPage.m
//  SYSU-Transfer
//
//  Created by mac on 2020/12/26.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransferHistoryPage.h"
#import "../View/TransferHistoryCell.h"
#import <AFNetworking/AFNetworking.h>

@interface TransferHistoryPage()<UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate>

//@property (nonatomic, strong)UIViewController *fst;

@property (nonatomic, strong)UILabel *upBar; // 顶部面板

@property (nonatomic, strong)UIProgressView *store; // 进度条

@property (nonatomic, strong)UITableView *tableView;    // 列表 tableView

@property (nonatomic, strong) UISearchBar *search; // 搜索栏

@property (nonatomic, strong) UIDatePicker *datePicker;// 选择日期

// Data
@property (nonatomic, strong)NSMutableArray<TransferHistoryCell *> *cells;

// 发生某些操作后要显示的数据的索引
@property (nonatomic, strong) NSMutableArray<NSNumber *> *showList;

// 标志着发生操作后显示 showList 中记录的索引的数据
@property NSInteger isOperated;

// 控制排序的顺序
@property NSInteger isAscending;

// location
@property CGFloat width;
@property CGFloat height;

@end

@implementation TransferHistoryPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    // array init
    _cells = [[NSMutableArray alloc] init];
    
    // root page
    //self = [[UIViewController alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"History";
    //[self pushViewController:self animated:YES];
    // [self.navigationController setNavigationBarHidden:YES];
    
    // tabbar icon setting
//    self.tabBarItem.title = @"传输历史";
//    self.tabBarItem.image = [[UIImage imageNamed:@"history.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"history_s.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // properties init
    _width = self.view.frame.size.width;
    _height = self.view.frame.size.height;
    
    // UI element init
    [self loadUpBar];
    [self loadBtns];
    [self loadStore];
    [self loadTable];
    
    // test
    //[self testData];
    
    // 表单还没有被操作过
    _isOperated = 0;
    // 定义第一次排序的顺序
    _isAscending = 1;
    // showlist
    _showList = [[NSMutableArray alloc] init];
    [self reFreshThisPage];
}


- (void)loadUpBar
{
    if (_upBar == nil) {
        _upBar = [[UILabel alloc] initWithFrame:CGRectMake(-1, 80, _width+2, 60)];
        
        _upBar.backgroundColor = UIColor.whiteColor;
        _upBar.layer.borderWidth = 1;
        _upBar.layer.borderColor = UIColor.grayColor.CGColor;
        //_upBar.layer.borderColor = UIColor.blackColor.CGColor;
        _upBar.layer.cornerRadius = 10;
    }
    
    [self.view addSubview:_upBar];
}

- (void)loadBtns
{
    int num = 4;
    CGFloat size = 30;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"riqi.png"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(self.view.frame.size.width/num - size/2, _upBar.frame.origin.y + 15, size, size);
    [btn1 addTarget:self action:@selector(ChangeDate:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"paixu.png"] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(self.view.frame.size.width/num*2 - size/2, _upBar.frame.origin.y + 15, size, size);
    [btn2 addTarget:self action:@selector(SortCells:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    btn3.frame = CGRectMake(self.view.frame.size.width/num*3 - size/2, _upBar.frame.origin.y + 15, size, size);
    [btn3 addTarget:self action:@selector(loadSearchBar:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
}

-(void)ChangeDate:(id)send{
    NSLog(@"change date is clicked");
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 100, _width+2, 90)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [self.datePicker addTarget:self action:@selector(datePickerEnd:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.datePicker];
    self.datePicker.hidden = NO;
}

-(NSString *)dataToEasyString:(NSDate *)date{
    NSString * temp =[[NSString alloc] initWithFormat:@"%@", date];
    NSString * res = [[NSString alloc] initWithFormat:@"%@", [temp substringToIndex:10]];
    return res;
}

-(void)datePickerEnd:(id)send{
    NSLog(@"datePickerEnd is clicked");
    NSString * temp = [self dataToEasyString:self.datePicker.date];
    
    [_showList removeAllObjects];
    _isOperated = 1;

    for(int i = 0; i < _cells.count; i ++) {
        if([_cells[i].file_time isEqualToString:temp]){
            [_showList addObject:[[NSNumber alloc] initWithInt:i]];
        }
    }
    
    [self.tableView reloadData];
    
    self.datePicker.hidden = YES;
}

-(void)SortCells:(id)send{
    NSLog(@"SortCells is clicked");
    
    if(_isAscending == 1){
        _isAscending = 0;
        for (int i = 0; i < [_cells count] - 1; i++) {
            for (int j = 0; j < [_cells count] - i - 1; j++) {
              if (NSOrderedAscending == [[_cells objectAtIndex:j].file_time compare:[_cells objectAtIndex:j + 1].file_time]) {
                [_cells exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
              }
            }
        }
    }else{
        _isAscending = 1;
        for (int i = 0; i < [_cells count] - 1; i++) {
            for (int j = 0; j < [_cells count] - i - 1; j++) {
              if (NSOrderedDescending == [[_cells objectAtIndex:j].file_time compare:[_cells objectAtIndex:j + 1].file_time]) {
                [_cells exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
              }
            }
        }
    }
    
    [self.tableView reloadData];
}


- (void)loadStore
{
    if (_store == nil) {
        int x = 30;
        _store = [[UIProgressView alloc] init];
        _store.frame = CGRectMake(x, _upBar.frame.size.height + _upBar.frame.origin.y + 5, _width-2*x, 20);
        
        _store.progressViewStyle = UIProgressViewStyleDefault;
        _store.progressTintColor = UIColor.greenColor;
        _store.trackTintColor = UIColor.grayColor;
        
        
        _store.progress = 0;
        [_store setProgress:0.5 animated:YES];
    }
    
    //[self.view addSubview:_store];
}

- (void)loadTable
{
    if (_tableView == nil) {
        int x = 20;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, _store.frame.origin.y, _width-2*x, _height - 200)];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = UIColor.whiteColor;
        
        [_tableView setScrollEnabled:YES];
        [_tableView setBounces:YES];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_tableView];
    }
}

- (void)testData
{
    // 生成随机的几条数据
    [_cells removeAllObjects];
    for (int i = 0; i < 3; i ++) {
        TransferHistoryCell *fc = [[TransferHistoryCell alloc] init];
        [fc test:i];
        
        // 把自己作为对象和方法的selector一起传递过去
        [fc setOperationsTarget:self WithSelector:@selector(test:)];
        
        [_cells addObject:fc];
    }
    
    [_tableView reloadData];
}

- (void)test:(TransferHistoryCell *)cell
{
    NSLog(@"option success");
    
    // init
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"选项" message:cell.file_name preferredStyle:UIAlertControllerStyleAlert];
    
    if ([cell style] == 1) {
        // add display
        UIAlertAction *displayAction =[UIAlertAction actionWithTitle:@"预览" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            NSLog(@"预览");
        }];
        [addAlertVC addAction:displayAction];
    }
    
    // add share
    UIAlertAction *shareAction =[UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"添加");
    }];
    [addAlertVC addAction:shareAction];
    
    // add share
    UIAlertAction *downLoadAction =[UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"下载");
    }];
    [addAlertVC addAction:downLoadAction];
    
    // add share
    UIAlertAction *renameAction =[UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"重命名");
    }];
    [addAlertVC addAction:renameAction];
    
    // add share
    UIAlertAction *deleteAction =[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"删除");
    }];
    [addAlertVC addAction:deleteAction];
    
    // add cancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [addAlertVC addAction:cancelAction];
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
}

#pragma mark - 重写----tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // 返回值是多少既有几个分区，一个分区
}

// 返回一个分区中有几行，如果被操作过，返回 showList 的长度，如果没有被操作过，返回 cells 的长度
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection");
    if(_isOperated == 1) return _showList.count;
    else return _cells.count;
}

// 返回每行的高度，如果被操作过要去根据 showlist 找
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_isOperated == 1) return _cells[[_showList[indexPath.row] integerValue]].height;
    else return _cells[indexPath.row].height;
}

// 返回具体的 UITableViewCell，如果被操作过，要根据 showlist 找
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    if(_isOperated == 1) return _cells[[_showList[indexPath.row] integerValue]];
    return _cells[indexPath.row];
}

//设置选中效果
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"selected cell");
}


// Search 相关
- (void)loadSearchBar:(id) sender {
    _search = [[UISearchBar alloc] initWithFrame:CGRectMake(-1, 80, _width+2, 60)];
    
    _search.layer.borderColor = [UIColor.grayColor CGColor];
    _search.layer.borderWidth = 1;
    _search.placeholder = @" 搜索框";
    _search.showsBookmarkButton = NO;
    _search.delegate = self;
    [_search setShowsCancelButton:YES animated:YES];
    [self.view addSubview:_search];
    self.search.hidden = NO;
}

// 搜获文件名包含 str 的数据，如果str是空那么初始化列表的情况
-(void)searchShow:(NSString *)str
{
    if([str isEqual:[[NSString alloc] initWithFormat:@""]]){
        NSLog(@"str is empty");
        _isOperated = 0;
        [self.tableView reloadData];
        return;
    }
    [_showList removeAllObjects];
    _isOperated = 1;

    for(int i = 0; i < _cells.count; i ++) {
        if([_cells[i].file_name containsString:str]){
            NSLog(@"%@", str);
            NSLog(@"%@", _cells[i].file_name);
            [_showList addObject:[[NSNumber alloc] initWithInt:i]];
            NSLog(@"%lu", (unsigned long)_showList.count);
        }
    }
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"SearchButton %@", searchBar.text);
    [self searchShow:searchBar.text];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.search.text = @"";
    [self searchShow:self.search.text];
    self.search.hidden = YES;
}

- (void) reFreshThisPage
{
    NSLog(@"Refresh this page");
    
    [self.cells removeAllObjects];
    [self.showList removeAllObjects];
    self.isOperated = 0;
    self.isAscending = 1;
    
    AFHTTPSessionManager *refreshPage = [[AFHTTPSessionManager alloc] init];
    refreshPage.responseSerializer = [AFJSONResponseSerializer serializer];
    refreshPage.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *refreshPageUrl = @"http://222.200.161.218:8080/share";
    [refreshPage GET:refreshPageUrl parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Http get share succeed!");
        
        NSUInteger k = [responseObject count];
        NSLog(@"%lu", (unsigned long)k);
        
        for(int i = 0; i < k; i++){
            NSLog(@"%@", [responseObject[i] valueForKey:@"name"]);
            TransferHistoryCell *fc = [[TransferHistoryCell alloc] init];
            [fc loadWithName:[responseObject[i] valueForKey:@"name"] WithId:[responseObject[i] valueForKey:@"id"] WithTime:[responseObject[i] valueForKey:@"createdAt"]];
            // 把自己作为对象和方法的selector一起传递过去
            [fc setOperationsTarget:self WithSelector:@selector(test:)];
            [self.cells addObject:fc];
        }
        
        [self.tableView reloadData];
        NSLog(@"Over!");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Http get share failed!");
    }];
}

@end
