//
//  FileProcessPage.m
//  SYSU-Transfer
//
//  Created by itlab on 2021/1/5.
//  Copyright © 2021 itlab. All rights reserved.
//

#import "FileProcessPage.h"
#import <Foundation/Foundation.h>

@interface FileProcessPage()<UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong)UILabel *upBar; // 顶部面板
@property (nonatomic, strong)UITableView *tableView;

// Data
@property (nonatomic, strong)NSMutableArray<NSNumber *> *selected;
@property BOOL selectAll;

// location
@property CGFloat width;
@property CGFloat height;

@end

@implementation FileProcessPage


- (instancetype)initWithCells:(NSMutableArray *)cells
{
    // properties init
    _width = self.view.frame.size.width;
    _height = self.view.frame.size.height;
    
    _selectAll = NO;
    
    self.cells = [[NSMutableArray alloc] init];
    self.selected = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < cells.count; i ++) {
        [self.selected addObject:[NSNumber numberWithBool:NO]];
        [self.cells addObject:[[[FileCell alloc] init] initWithCell:cells[i]]];
    }
    
    // UI element init
    [self loadUpBar];
    [self loadBtns];
    [self loadTable];
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.navigationItem setTitle:@"多选"];
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
    if (!_cells[indexPath.row].canDelete) return;
    
    _selected[indexPath.row] = [NSNumber numberWithBool:! [_selected[indexPath.row] boolValue]];
    [_cells[indexPath.row] changeMark:_selected[indexPath.row]];
}

# pragma mark - button

- (void)loadBtns
{
    int num = 5;
    CGFloat size = 30;
    CGFloat up = _upBar.frame.origin.y + 15;
    CGFloat border = self.view.frame.size.width/(num+1);
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"unselected.png"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(border - size/2, up, size, size);
    [btn1 addTarget:self action:@selector(selectSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"move.png"] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(border*2 - size/2, up, size, size);
    [btn2 addTarget:self action:@selector(selectMove) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"download.png"] forState:UIControlStateNormal];
    btn3.frame = CGRectMake(border*3 - size/2, up, size, size);
    [btn3 addTarget:self action:@selector(selectDownload) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn4 setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    btn4.frame = CGRectMake(border*4 - size/2, up, size, size);
    [btn4 addTarget:self action:@selector(selectDelete) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn5 setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    btn5.frame = CGRectMake(border*5 - size/2, up, size, size);
    [btn5 addTarget:self action:@selector(selectClose) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    [self.view addSubview:btn5];
}

- (void)selectSelected:(UIButton *)btn
{
    if (_selectAll) {
        for (int i = 0; i < _selected.count; i ++) {
            if (!_cells[i].canDelete) continue;
            
            [btn setBackgroundImage:[UIImage imageNamed:@"unselected.png"] forState:UIControlStateNormal];
            
            _selectAll = NO;
            _selected[i] = [NSNumber numberWithBool:NO];
            [_cells[i] changeMark:_selected[i]];
        }
    } else {
        for (int i = 0; i < _selected.count; i ++) {
            if (!_cells[i].canDelete) continue;
            
            [btn setBackgroundImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
            
            _selectAll = YES;
            _selected[i] = [NSNumber numberWithBool:YES];
            [_cells[i] changeMark:_selected[i]];
        }
    }
}

- (void)selectMove
{
    BOOL state = YES;
    for (int i = 0; i < _selected.count; i ++) {
        if ([_selected[i] boolValue]== YES) {
            state = NO;
            break;
        }
    }
    if (state) return;
    
    
    NSMutableArray<FileCell *> *tmp = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.cells.count; i ++) {
        if ([self.selected[i] boolValue]) {
            [tmp addObject:self.cells[i]];
        }
    }
    MovePage *MP = [[[MovePage alloc] init] initWithPath:self.parent.fileInfo.fullPath WithCell:tmp];
    [self.navigationController pushViewController:MP animated:YES];
}

- (void)selectDownload
{
    BOOL state = YES;
    for (int i = 0; i < _selected.count; i ++) {
        if ([_selected[i] boolValue]== YES) {
            state = NO;
            break;
        }
    }
    if (state) return;
    
    // download all selected cells
    for (int i = 0; i < _selected.count; i ++) {
        if ([_selected[i] boolValue]== YES) {
            [self.cells[i] download];
        }
    }
}

- (void)selectDelete
{
    BOOL state = YES;
    for (int i = 0; i < _selected.count; i ++) {
        if ([_selected[i] boolValue]== YES) {
            state = NO;
            break;
        }
    }
    
    if (state) return;
    
    for (int i = 0; i < _selected.count; i ++) {
        if ([_selected[i] boolValue]== YES) {
            extern AFHTTPSessionManager *httpManager;
            File *target = _cells[i].fileInfo;
            BOOL realFolder = _cells[i].isFloder;
            
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
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectClose
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
