//
//  LocalFilePage.m
//  SYSU-Transfer
//
//  Created by itlab on 2020/12/24.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImgDisplay.h"
#import "LocalFilePage.h"

@interface LocalFilePage()<UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong)UILabel *upBar; // 顶部面板
@property (nonatomic, strong)UIProgressView *store;
@property (nonatomic, strong)UITableView *tableView;

// Data
@property (nonatomic, strong)NSMutableArray<LocalFileCell *> *cells;

// location
@property CGFloat width;
@property CGFloat height;

@end

@implementation LocalFilePage

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
    // [self loadFloaderInfo];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self refresh];
    NSLog(@"appear");
}

- (void)loadFloaderInfo
{
    _cells = [[NSMutableArray alloc] init];
    
    NSArray *dir = [FileManager ReadDirByPath:self.path];
    
    NSLog(@"loadFloaderInfo = %@", dir);
    
    NSString *str;
    for (int i = 0; i < dir.count; i ++) {
        str = [dir objectAtIndex:i];
        LocalFileCell *lfc = [[LocalFileCell alloc] init];
        
        NSLog(@"count = %@", str);
        NSString *fullPath = [[NSString alloc] initWithFormat:@"%@/%@", self.path, str];
        
        [lfc setOperationsTarget:self WithSelector:@selector(options:)];
        
        lfc.isFloder = [FileManager fileIsFolder:fullPath];
        lfc.path = fullPath;
        lfc.file_name = str;
        
        [lfc loadPage];
        [self.cells addObject:lfc];
    }
    
    [self sortWithType];
}

- (void)initWithFloder:(LocalFileCell *)fc
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

- (void)options:(LocalFileCell *)cell
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
    UIAlertAction *shareAction =[UIAlertAction actionWithTitle:@"上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"上传");
        
        __block LocalFileCell *tar;
        BOOL has = NO;
        for (LocalFileCell* item in self.cells) {
            if ([item isEqual:cell]) {
                tar = item;
                has = YES;
                break;
            }
        }
        
        if (has) {
            
            AFHTTPSessionManager* manager =[AFHTTPSessionManager manager];
            manager.requestSerializer.timeoutInterval = 20;
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
            NSString* url = @"http://222.200.161.218:8080/files/";
            
            [manager POST:url parameters:nil headers:nil
            constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [formData appendPartWithFileData:tar.file_data name:@"file" fileName:tar.file_name mimeType:@"multipart/form-data"];
                NSString *str = @"local";
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                [formData appendPartWithFormData:data name:@"fullPath"];
            }
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSLog(@"upload success %@", responseObject);
                  }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      NSLog(@"upload error = %@", error);
                  }];
            
        } else {
            NSLog(@"get file error");
        }
        
    }];
    [addAlertVC addAction:shareAction];
    
    // add delete
    UIAlertAction *deleteAction =[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        File *target = [[File alloc] init];
        BOOL realFolder = NO;
        
        if (cell.isFloder && cell.fileInfo.children.count != 0) {
            [self errorPage:@"请先清空文件夹"];
        } else {
            NSMutableArray *new_arr = [[NSMutableArray alloc] init];
            
            for (LocalFileCell* item in self.cells) {
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
            
            [FileManager DeleteFileByName:cell.path];
            [self refresh];
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

- (void)cellDisplay:(LocalFileCell *)cell
{
    ImgDisplay *ids = [[[ImgDisplay alloc] init] initWithPic:[UIImage imageWithData:cell.file_data] withThumb:cell.file_name];
    [self.navigationController pushViewController:ids animated:YES];
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
        LocalFilePage *LFP = [[LocalFilePage alloc] init];
        LFP.path = self.cells[indexPath.row].path;
        [LFP.navigationItem setTitle:self.cells[indexPath.row].file_name];
        
        [self.navigationController pushViewController:LFP animated:YES];
    }
}

# pragma mark - button

- (void)loadBtns
{
    int num = 2;
    CGFloat size = 30;
    CGFloat up = _upBar.frame.origin.y + 15;
    CGFloat border = self.view.frame.size.width/(num+1);

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"sort.png"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(border*1 - size/2, up, size, size);
    [btn1 addTarget:self action:@selector(selectSort) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(border*2 - size/2, up, size, size);
    [btn2 addTarget:self action:@selector(selectSearch) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
}

- (void)selectSort
{
    [self sortCells:0];
}

- (void)selectSearch
{
    NSLog(@"search");
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
    NSMutableArray<LocalFileCell *> *tmp = [[NSMutableArray alloc] init];
    
    for (NSInteger i = _cells.count-1; i >= 0; i --) {
        [tmp addObject:_cells[i]];
    }
    
    _cells = [[NSMutableArray alloc] initWithArray:tmp];
    [self.tableView reloadData];
}

- (void)sortWithType
{
    LocalFileCell *tmp;
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
