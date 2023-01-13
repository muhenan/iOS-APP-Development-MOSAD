//
//  DisplayImages.m
//  ios-hw3-muhenan
//
//  Created by mac on 2020/12/10.
//

#import <Foundation/Foundation.h>
#import "DisplayImages.h"


@implementation DisplayImages

- (id)init{
    self = [super init];
    _urls = [[NSMutableArray alloc] init];
    
    [_urls addObject:@"https://hbimg.huabanimg.com/d8784bbeac692c01b36c0d4ff0e072027bb3209b106138-hwjOwX_fw658"];
    [_urls addObject:@"https://hbimg.huabanimg.com/6215ba6f9b4d53d567795be94a90289c0151ce73400a7-V2tZw8_fw658"];
    [_urls addObject:@"https://hbimg.huabanimg.com/834ccefee93d52a3a2694535d6aadc4bfba110cb55657-mDbhv8_fw658"];
    [_urls addObject:@"https://hbimg.huabanimg.com/f3085171af2a2993a446fe9c2339f6b2b89bc45f4e79d-LacPMl_fw658"];
    [_urls addObject:@"https://hbimg.huabanimg.com/e5c11e316e90656dd3164cb97de6f1840bdcc2671bdc4-vwCOou_fw658"];
    
//    _isloading = [[NSMutableArray alloc] init];
//    [_isloading addObject:@"NO"];
//    [_isloading addObject:@"NO"];
//    [_isloading addObject:@"NO"];
//    [_isloading addObject:@"NO"];
//    [_isloading addObject:@"NO"];
//    _isclear = [[NSMutableArray alloc] init];
//    [_isclear addObject:@"NO"];
//    [_isclear addObject:@"NO"];
//    [_isclear addObject:@"NO"];
//    [_isclear addObject:@"NO"];
//    [_isclear addObject:@"NO"];
    
    _filePaths = [[NSMutableArray alloc]init];
    // 获取Cache目录
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains
        (NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    [_filePaths addObject:[cachePath stringByAppendingPathComponent:@"photo1"]];
    [_filePaths addObject:[cachePath stringByAppendingPathComponent:@"photo2"]];
    [_filePaths addObject:[cachePath stringByAppendingPathComponent:@"photo3"]];
    [_filePaths addObject:[cachePath stringByAppendingPathComponent:@"photo4"]];
    [_filePaths addObject:[cachePath stringByAppendingPathComponent:@"photo5"]];
    
    _isloading = NO;
    _isclear = NO;
    
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    //设置显示位置
    _indicator.center = CGPointMake(100.0f, 125.0f);
    //将这个控件加到父容器中。
    [self.view addSubview:_indicator];
    
    return  self;
}

- (void)loadView
{
    [super loadView];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.buttonLoad];
    [self.view addSubview:self.buttonClear];
    [self.view addSubview:self.buttonClearCache];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(UIButton*)buttonLoad{
    if(_buttonLoad == nil){
        _buttonLoad = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 50,30 )];
        [_buttonLoad setShowsTouchWhenHighlighted:NO];
        [_buttonLoad.layer setBorderWidth:1.0];
        [_buttonLoad.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonLoad.layer setCornerRadius:10.0];
        [_buttonLoad setTitle:@"加载" forState: UIControlStateNormal];
        [_buttonLoad setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buttonLoad addTarget:self action:@selector(clickLoad:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonLoad;
}



-(void) clickLoad:(id)sender{
    NSLog(@"load is clicked");
    [_indicator startAnimating];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSError *error = nil;
    
    // 获取Cache目录
//    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains
//        (NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachePath = [cachePaths objectAtIndex:0];
//    NSString *filePath1 = [cachePath stringByAppendingPathComponent:@"photo1"];
    
//    for(int i = 0; i < 5; i++){
//        [_isloading replaceObjectAtIndex:i withObject:@"YES"];
//    }
    _isclear = NO;
    _isloading = YES;
    [_tableView reloadData];
    
    for(int i = 0; i < 5; i++){
        if([fileManager fileExistsAtPath:[_filePaths objectAtIndex:i]]){
            NSLog(@"photo%d exists", (i+1));
        }else{
            NSLog(@"photo%d doesn't exist", (i+1));
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_urls objectAtIndex:i]]];
            [data writeToFile:[_filePaths objectAtIndex:i] atomically:YES];
            NSLog(@"photo%d has been downloaded", (i+1));
        }
    }
    
//    if ([fileManager fileExistsAtPath:filePath1]) {
//        NSLog(@"photo1 exists");
//    }else{
//        NSLog(@"photo1 doesn't exist");
//        NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_urls objectAtIndex:0]]];
//        [data1 writeToFile:filePath1 atomically:YES];
//        NSLog(@"photo1 has been downloaded");
//    }
//    for(int i = 0; i < 5; i++){
//        [_isloading replaceObjectAtIndex:i withObject:@"NO"];
//    }
    _isloading = NO;
    [_indicator stopAnimating];
    [_tableView reloadData];
    return;
}

-(UIButton*)buttonClear{
    if(_buttonClear == nil){
        _buttonClear = [[UIButton alloc]initWithFrame:CGRectMake(150, 50, 50,30 )];
        [_buttonClear setShowsTouchWhenHighlighted:NO];
        [_buttonClear.layer setBorderWidth:1.0];
        [_buttonClear.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonClear.layer setCornerRadius:10.0];
        [_buttonClear setTitle:@"清空" forState: UIControlStateNormal];
        [_buttonClear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buttonClear addTarget:self action:@selector(clickClear:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonClear;
}

-(void)clickClear:(id)sender{
    NSLog(@"clear is clicked");
    _isclear = YES;
    [_tableView reloadData];
}

-(UIButton*)buttonClearCache{
    if(_buttonClearCache == nil){
        _buttonClearCache = [[UIButton alloc]initWithFrame:CGRectMake(250, 50, 100,30 )];
        [_buttonClearCache setShowsTouchWhenHighlighted:NO];
        [_buttonClearCache.layer setBorderWidth:1.0];
        [_buttonClearCache.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonClearCache.layer setCornerRadius:10.0];
        [_buttonClearCache setTitle:@"删除缓存" forState: UIControlStateNormal];
        [_buttonClearCache setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buttonClearCache addTarget:self action:@selector(clickClearCache:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonClearCache;
}

-(void)clickClearCache:(id)sender{
    NSLog(@"clearCache is clicked");
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 获取Cache目录
//    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains
//        (NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachePath = [cachePaths objectAtIndex:0];
//    NSString *filePath1 = [cachePath stringByAppendingPathComponent:@"photo1"];
//
//    if ([fileManager fileExistsAtPath:filePath1]) {
//        NSLog(@"photo1 exists");
//        [fileManager removeItemAtPath:filePath1 error:nil];
//        NSLog(@"photo1 has been removed");
//    }else{
//        NSLog(@"photo1 dosen't exist");
//    }
    for(int i = 0; i < 5; i++){
        if([fileManager fileExistsAtPath:[_filePaths objectAtIndex:i]]){
            NSLog(@"photo%d exists", (i+1));
            [fileManager removeItemAtPath:[_filePaths objectAtIndex:i] error:nil];
            NSLog(@"photo%d has been removed", (i+1));
        }else{
            NSLog(@"photo%d doesn't exist", (i+1));
        }
    }
    
    [_tableView reloadData];
}


- (UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-200) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
       [_tableView setScrollEnabled:YES];
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去除分割线
    }
    return _tableView;
}

#pragma mark - 重写----设置有groupTableView有几个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5; // 返回值是多少既有几个分区
}


#pragma mark - 重写----设置每个分区有几个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tableView  cellForRowAtIndexPath");
    // 设置一个标示符
    static NSString *cell_id = @"cell_id";
    //
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    // 判断cell是否存在
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        cell.backgroundColor = [UIColor clearColor];
    }
    // 分别给每个分区的单元格设置显示的内容
    if(indexPath.row == 0){
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //NSError *errorNil = nil;
        
        // 获取Cache目录
//        NSArray *cachePaths = NSSearchPathForDirectoriesInDomains
//            (NSCachesDirectory, NSUserDomainMask, YES);
//        NSString *cachePath = [cachePaths objectAtIndex:0];
//        NSString *filePath1 = [cachePath stringByAppendingPathComponent:@"photo1"];
        
        
        if(_isloading){
            NSLog(@"set loading");
            [cell.imageView setImage:[UIImage imageNamed:@"loading-2.png"]];
        }else if(_isclear){
            NSLog(@"set nil from clear");
            [cell.imageView setImage:nil];
        }else{
            NSLog(@"no loading and clear");
            if ([fileManager fileExistsAtPath:[_filePaths objectAtIndex:indexPath.section]]) {
                NSData *dataPhoto = [NSData dataWithContentsOfFile:[_filePaths objectAtIndex:indexPath.section]];
                [cell.imageView setImage:[UIImage imageWithData:dataPhoto]];
            }else{
                [cell.imageView setImage:nil];
            }
        }
    }
    return cell;
}

@end
