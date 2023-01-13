//
//  MovePage.m
//  SYSU-Transfer
//
//  Created by itlab on 2021/1/6.
//  Copyright © 2021 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovePage.h"

@interface MovePage() <UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong)NSMutableArray<FileCell *> *cells;
@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UILabel *upBar; // 顶部面板

// location
@property CGFloat width;
@property CGFloat height;

// stack
@property (nonatomic, strong)NSMutableArray<File *> *folderStack;

@end

@implementation MovePage

- (instancetype)initWithPath:(NSString *)path WithCell:(NSMutableArray<FileCell *> *)cells
{
    self.selectedCells = [[NSMutableArray alloc] initWithArray:cells];
    self.cells = [[NSMutableArray alloc] init];
    self.folderStack = [[NSMutableArray alloc] init];
    self.path = path;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.navigationItem setTitle:@"移动到"];
    
    // properties init
    _width = self.view.frame.size.width;
    _height = self.view.frame.size.height;
    
    [self loadUpBar];
    [self loadBtns];
    [self loadTable];
    
    // data
    [self loadFolderInfo];
}

- (void)reloadData
{
    extern AFHTTPSessionManager *httpManager;
    // get root
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@", @"/folders", self.fileInfo.fullPath];
    
    [httpManager POST:url
           parameters:@{
                        }
              headers:nil
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                  // NSLog(@"response object = %@", responseObject);
                  
                  self.fileInfo = [File dic2Object:responseObject];
                  
                  [self.cells removeAllObjects];
                  for (int i = 0; i < self.fileInfo.children.count; i ++) {
                      FileCell *fc = [[[FileCell alloc] init] initMoveCellWithInfo:self.fileInfo.children[i]];
                      fc.cell_id = i;
                      [self.cells addObject:fc];
                  }
                  
                  [self.folderStack addObject:self.fileInfo];
                  [self.tableView reloadData];
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                  NSLog(@"get root fail");
              }];
}

- (void)loadFolderInfo
{
    extern AFHTTPSessionManager *httpManager;
    // get root
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@", @"/folders", @"/"];
    
    [httpManager POST:url
           parameters:@{
                        }
              headers:nil
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                  // NSLog(@"response object = %@", responseObject);
                  
                  self.fileInfo = [File dic2Object:responseObject];
                  
                  [self.cells removeAllObjects];
                  for (int i = 0; i < self.fileInfo.children.count; i ++) {
                      if (! [self.fileInfo.children[i].type isEqualToString:@"FOLDER"]) continue;
                      
                      FileCell *fc = [[[FileCell alloc] init] initMoveCellWithInfo:self.fileInfo.children[i]];
                      fc.cell_id = i;
                      [self.cells addObject:fc];
                  }
                  
                  [self.tableView reloadData];
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                  NSLog(@"get root fail");
              }];
}

- (void)loadTable
{
    if (_tableView == nil) {
        int x = 20;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, _upBar.frame.origin.y + 70, _width-2*x, _height - 200)];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = UIColor.whiteColor;
        
        [_tableView setScrollEnabled:YES];
        [_tableView setBounces:YES];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_tableView];
    }
}

#pragma mark - 重写----tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // 返回值是多少既有几个分区
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cells.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cells[indexPath.row].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cells[indexPath.row];
}

//设置选中效果
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"push folder");
    
    self.fileInfo = self.fileInfo.children[_cells[indexPath.row].cell_id];
    [self reloadData];
}

#pragma mark - upBar

- (void)loadUpBar
{
    if (_upBar == nil) {
        _upBar = [[UILabel alloc] initWithFrame:CGRectMake(-1, 80, _width+2, 50)];
        
        _upBar.backgroundColor = UIColor.whiteColor;
        _upBar.layer.borderWidth = 0.2;
        _upBar.layer.borderColor = UIColor.grayColor.CGColor;
        _upBar.layer.cornerRadius = 10;
    }
    
    [self.view addSubview:_upBar];
}

- (void)loadBtns
{
    int num = 3;
    CGFloat size = 30;
    CGFloat up = _upBar.frame.origin.y + 15;
    CGFloat border = self.view.frame.size.width/(num+1);
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(border - size/2, up, size, size);
    [btn1 addTarget:self action:@selector(selectBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(border*2 - size/2, up, size, size);
    [btn2 addTarget:self action:@selector(selectOK) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    btn3.frame = CGRectMake(border*3 - size/2, up, size, size);
    [btn3 addTarget:self action:@selector(selectClose) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
}

- (void)selectBack
{
    NSInteger index = _folderStack.count-2;
    _folderStack = [[NSMutableArray alloc] initWithArray:[_folderStack subarrayWithRange:NSMakeRange(0, _folderStack.count-1)]];
    
    _fileInfo = _folderStack[index];
    [self reloadData];
}

- (void)selectClose
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectOK
{
    NSLog(@"ok");
    
    if([self.fileInfo.fullPath isEqualToString:self.path]) {
        [self errorPage:@"不能移动到原文件夹"];
    } else {
        for (int i = 0; i < self.selectedCells.count; i ++) {
            [self.selectedCells[i] moveTo:self.fileInfo.fullPath];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)errorPage:(NSString *)detail;
{
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"操作错误" message:detail preferredStyle:UIAlertControllerStyleAlert];
    // 创建取消事件(按钮)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    // 添加 取消事件 到 弹窗界面
    [addAlertVC addAction:cancelAction];
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
}

@end
