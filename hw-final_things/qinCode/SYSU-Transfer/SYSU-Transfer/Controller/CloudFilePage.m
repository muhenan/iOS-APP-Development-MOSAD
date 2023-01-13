//
//  CloudFilePage.m
//  SYSU-Transfer
//
//  Created by itlab on 2020/12/24.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudFilePage.h"
#import "ImgDisplay.h"
#import "FileCell.h"

@interface CloudFilePage()<UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong)UILabel *upBar; // 顶部面板
@property (nonatomic, strong)UIProgressView *store;
@property (nonatomic, strong)UITableView *tableView;

// Data
@property (nonatomic, strong)NSMutableArray<FileCell *> *cells;

// location
@property CGFloat width;
@property CGFloat height;

@end

@implementation CloudFilePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    // array init
    _cells = [[NSMutableArray alloc] init];
    
    // root page
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"Cloud";
    
    // properties init
    _width = self.view.frame.size.width;
    _height = self.view.frame.size.height;
    
    // UI element init
    [self loadUpBar];
    [self loadBtns];
    [self loadStore];
    [self loadTable];
    
    // test
    [self testData];
}

- (void)initWithFloder:(FileCell *)fc
{
    self.navigationItem.title = fc.file_name;
}

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
    int num = 5;
    CGFloat size = 35;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"cloud.png"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(self.view.frame.size.width/num - size/2, _upBar.frame.origin.y + 12, size, size);
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"cloud.png"] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(self.view.frame.size.width/num*2 - size/2, _upBar.frame.origin.y + 12, size, size);
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
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
    
    [self.view addSubview:_store];
}

- (void)loadTable
{
    if (_tableView == nil) {
        int x = 20;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, _store.frame.origin.y + 15, _width-2*x, _height - 200)];
        
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
    [_cells removeAllObjects];
    
    FileCell *fc = [[FileCell alloc] init];
    [fc testFloder];
    fc.cell_id = 4;
    [fc setOperationsTarget:self WithSelector:@selector(options:)];
    [_cells addObject:fc];
    
    for (int i = 0; i < 3; i ++) {
        FileCell *fc = [[FileCell alloc] init];
        [fc test:i];
        
        // 把自己作为对象和方法的selector一起传递过去
        [fc setOperationsTarget:self WithSelector:@selector(options:)];
        fc.cell_id = i;
        [_cells addObject:fc];
    }
    
    [_tableView reloadData];
}

- (void)options:(FileCell *)cell
{
    NSLog(@"option success");
    
    // init
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"选项" message:cell.file_name preferredStyle:UIAlertControllerStyleAlert];
    
    if ([cell style] == 1) {
        // add display
        UIAlertAction *displayAction =[UIAlertAction actionWithTitle:@"预览" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            NSLog(@"预览");
            
            [self cellDisplay:cell];
        }];
        [addAlertVC addAction:displayAction];
    }
    
    // add share
    UIAlertAction *downLoadAction =[UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"下载");
    }];
    [addAlertVC addAction:downLoadAction];
    
    // add share
    UIAlertAction *renameAction =[UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"重命名");
        
        [self cellRename:cell];
    }];
    [addAlertVC addAction:renameAction];
    
    // add share
    UIAlertAction *deleteAction =[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        NSMutableArray *new_arr = [[NSMutableArray alloc] init];
        for (FileCell* item in self.cells) {
            if ([item isEqual:cell]) {
                continue;
            }
            [new_arr addObject:item];
        }
        
        self.cells = new_arr;
        
        [self.tableView reloadData];
        NSLog(@"删除");
    }];
    [addAlertVC addAction:deleteAction];
    
    // add cancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [addAlertVC addAction:cancelAction];
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
}

- (void)cellDisplay:(FileCell *)cell
{
    ImgDisplay *ids = [[[ImgDisplay alloc] init] initWithPic:cell.file_icon withThumb:cell.file_name];
    [self.navigationController pushViewController:ids animated:YES];
}

- (void)cellRename:(FileCell *)cell
{
    // 创建一个弹框
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"重命名" message:@"请输入新的文件名" preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建两个textFiled输入框
    [addAlertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = cell.file_name;
    }];
    
    // 创建取消事件(按钮)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    // 添加 取消事件 到 弹窗界面
    [addAlertVC addAction:cancelAction];
    
    
    // 创建 确认按钮(事件) 并添加到弹窗界面
    UIAlertAction *confirmAction =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSString *name = [[NSString alloc] initWithFormat:@"%@", addAlertVC.textFields.firstObject.text];
        
        for (FileCell* item in self.cells) {
            if ([item isEqual:cell]) {
                [item rename:name];
                break;
            }
        }
        
        // [self.tableView reloadData];
    }];
    //添加确定按钮(事件)到弹窗
    [addAlertVC addAction:confirmAction];
    
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
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
    NSLog(@"selected cell");
    
    if (_cells[indexPath.row].isFloder) {
        CloudFilePage *CFP = [[CloudFilePage alloc] init];
        [CFP  initWithFloder:_cells[indexPath.row]];
        [self.navigationController pushViewController:CFP animated:YES];
    }
}

@end
