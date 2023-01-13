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
#import "FileProcessPage.h"
#import "../View/FileCell.h"

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
    
    // properties init
    _width = self.view.frame.size.width;
    _height = self.view.frame.size.height;
    
    // UI element init
    [self loadUpBar];
    [self loadBtns];
    [self loadStore];
    [self loadTable];
    
    // test
    // [self testData];
    [self loadFloaderInfo];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self refresh];
    NSLog(@"appear");
}

- (void)showFloaderInfo
{
    [self.cells removeAllObjects];
    for (int i = 0; i < self.fileInfo.children.count; i ++) {
        FileCell *fc = [[[FileCell alloc] init] initWithInfo:self.fileInfo.children[i]];
        
        fc.cell_id = i;
        [fc setOperationsTarget:self WithSelector:@selector(options:)];
        [self.cells addObject:fc];
    }
    
    [self sortWithType];
}

- (void)loadFloaderInfo
{
    extern AFHTTPSessionManager *httpManager;
    // get root
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@", @"/folders", self.path];
    
    [httpManager POST:url
           parameters:@{
                        }
              headers:nil
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                  NSLog(@"get root");
                  if ([self.path isEqualToString:@"/"]) {
                      NSLog(@"response object = %@", responseObject);
                  }
                  self.fileInfo = [File dic2Object:responseObject];
                  
                  [self.cells removeAllObjects];
                  for (int i = 0; i < self.fileInfo.children.count; i ++) {
                      FileCell *fc = [[[FileCell alloc] init] initWithInfo:self.fileInfo.children[i]];
                      fc.cell_id = i;
                      [fc setOperationsTarget:self WithSelector:@selector(options:)];
                      [self.cells addObject:fc];
                  }
                  
                  [self sortWithType];
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                  NSLog(@"get root fail");
              }];
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
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:cell.file_name message:@"选项" preferredStyle:UIAlertControllerStyleAlert];
    
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
        
        for (FileCell* item in self.cells) {
            if ([item isEqual:cell]) {
                [item loadFileData];
                [item download];
            }
        }
    }];
    [addAlertVC addAction:downLoadAction];
    
    // add share
    UIAlertAction *shareAction =[UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"分享");
        
        FileCell *tar;
        BOOL has = NO;
        for (FileCell* item in self.cells) {
            if ([item isEqual:cell]) {
                tar = item;
                has = YES;
                break;
            }
        }
        
        if (has) {
            extern AFHTTPSessionManager *httpManager;
            
            [httpManager POST:@"/share"
                   parameters:@{
                                @"fileid": [[NSString alloc] initWithFormat:@"%ld", cell.fileInfo.ID],
                                }
                      headers:nil
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          NSLog(@"%@ share success", cell.fileInfo.name);
                     }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          NSLog(@"ERROR: %@ share fail", cell.fileInfo.name);
                      }];
            
        } else {
            NSLog(@"get file error");
        }
        
    }];
    [addAlertVC addAction:shareAction];
    
    // add rename
    UIAlertAction *renameAction =[UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"重命名");
        
        [self cellRename:cell];
    }];
    [addAlertVC addAction:renameAction];
    
    // add delete
    UIAlertAction *deleteAction =[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        File *target = [[File alloc] init];
        BOOL realFolder = NO;
        
        if (cell.isFloder && cell.fileInfo.children.count != 0) {
            [self errorPage:@"请先清空文件夹"];
        } else {
            NSMutableArray *new_arr = [[NSMutableArray alloc] init];
            
            for (FileCell* item in self.cells) {
                if ([item isEqual:cell]) {
                    NSLog(@"fullpath = %@", cell.fileInfo.fullPath);
                    
                    target.fullPath = item.fileInfo.fullPath;
                    target.name = item.fileInfo.name;
                    target.ID = item.fileInfo.ID;
                    realFolder = item.isFloder;
                    continue;
                }
                [new_arr addObject:item];
            }
            
            self.cells = new_arr;
            
            [self.tableView reloadData];
            NSLog(@"删除");
            
            // delete in server
            extern AFHTTPSessionManager *httpManager;
            if (realFolder) {
                NSString *url = [[NSString alloc] initWithFormat:@"/folders%@", target.fullPath];
                [httpManager DELETE:url parameters:nil headers:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                NSLog(@"Folder %@ delete success", target.fullPath);
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                NSLog(@"Folder %@ delete fail, err=%@", target.fullPath, error);
                            }];
            } else {
                NSString *url = [[NSString alloc] initWithFormat:@"/files/%ld", target.ID];
                [httpManager DELETE:url parameters:nil headers:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                NSLog(@"File %@ delete success", target.name);
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                NSLog(@"File %@ delete fail", target.name);
                            }];
            }
        }
    }];
    [addAlertVC addAction:deleteAction];
    
    // add cancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [addAlertVC addAction:cancelAction];
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
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

- (void)cellDisplay:(FileCell *)cell
{
    ImgDisplay *ids = [[[ImgDisplay alloc] init] initWithPic:[UIImage imageWithData:cell.file_data] withThumb:cell.file_name];
    [self.navigationController pushViewController:ids animated:YES];
}

- (void)cellRename:(FileCell *)cell
{
    // 创建一个弹框
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"重命名" message:@"请输入新的文件名" preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建textFiled输入框
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
        CFP.path = self.fileInfo.children[self.cells[indexPath.row].cell_id].fullPath;
        [CFP  initWithFloder:_cells[indexPath.row]];
        [self.navigationController pushViewController:CFP animated:YES];
    }
}

# pragma mark - button

- (void)loadBtns
{
    int num = 5;
    CGFloat size = 30;
    CGFloat up = _upBar.frame.origin.y + 15;
    CGFloat border = self.view.frame.size.width/(num+1);
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"create.png"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(border - size/2, up, size, size);
    [btn1 addTarget:self action:@selector(selectCreate) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(border*2 - size/2, up, size, size);
    [btn2 addTarget:self action:@selector(selectUpload) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"sort.png"] forState:UIControlStateNormal];
    btn3.frame = CGRectMake(border*3 - size/2, up, size, size);
    [btn3 addTarget:self action:@selector(selectSort) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn4 setBackgroundImage:[UIImage imageNamed:@"multi.png"] forState:UIControlStateNormal];
    btn4.frame = CGRectMake(border*4 - size/2, up, size, size);
    [btn4 addTarget:self action:@selector(selectMulti) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn5 setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    btn5.frame = CGRectMake(border*5 - size/2, up, size, size);
    [btn5 addTarget:self action:@selector(selectSearch) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    [self.view addSubview:btn5];
}

- (void)selectCreate
{
    NSLog(@"Create Flodder");
    
    // 创建一个弹框
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"重命名" message:@"请输入新的文件名" preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建textFiled输入框
    [addAlertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Floder Name";
    }];
    
    // 创建取消事件(按钮)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    // 添加 取消事件 到 弹窗界面
    [addAlertVC addAction:cancelAction];
    
    
    // 创建 确认按钮(事件) 并添加到弹窗界面
    UIAlertAction *confirmAction =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSString *name = [[NSString alloc] initWithFormat:@"%@", addAlertVC.textFields.firstObject.text];
        
        extern AFHTTPSessionManager *httpManager;
        NSString *url = [[NSString alloc] initWithFormat:@"/folders%@%@/", self.fileInfo.fullPath, name];
        [httpManager POST:url parameters:nil headers:nil progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"Folder %@ create success", name);
                      
                    [self refresh];
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      NSLog(@"Folder %@ create fail", name);
                  }];
        
    }];
    //添加确定按钮(事件)到弹窗
    [addAlertVC addAction:confirmAction];
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
}

- (void)selectMulti
{
    NSLog(@"select Multi");
    
    FileProcessPage *FPP = [[[FileProcessPage alloc] init] initWithCells:_cells];
    FPP.parent = self;
    
    [self.navigationController pushViewController:FPP animated:YES];
}

- (void)selectSort
{
    [self sortCells:0];
}

- (void)selectSearch
{
    
}

- (void)selectUpload
{
    
}

# pragma mark - sort
- (void)sortCells:(int)type
{
    switch (type) {
        case 0:
            [self sortCellReverse];
            break;
        case 1:
            [self sortWithType];
            break;
            
        default:
            break;
    }
}

- (void)sortCellReverse
{
    NSMutableArray<FileCell *> *tmp = [[NSMutableArray alloc] init];
    
    for (NSInteger i = _cells.count-1; i >= 0; i --) {
        [tmp addObject:_cells[i]];
    }
    
    _cells = [[NSMutableArray alloc] initWithArray:tmp];
    [self.tableView reloadData];
}

- (void)sortWithType
{
    FileCell *tmp;
    for (int i = 0 ; i < _cells.count; i ++) {
        for (int j = i + 1; j < _cells.count; j ++) {
            if (_cells[i].style > _cells[j].style) {
                tmp = _cells[i];
                _cells[i] = _cells[j];
                _cells[j] = tmp;
            }
        }
    }
    
    [self.tableView reloadData];
}

- (void)refresh
{
    [self loadFloaderInfo];
}

@end
