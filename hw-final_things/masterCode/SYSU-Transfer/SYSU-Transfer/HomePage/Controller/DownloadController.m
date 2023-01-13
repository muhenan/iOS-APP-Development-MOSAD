//
//  UploadController.m
//  HomePage
//
//  Created by nz on 2020/12/25.
//

#import <Foundation/Foundation.h>
#import "DownloadController.h"

@interface DownloadController()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic)int num;
@property(nonatomic) UIButton* editButton;
@property(nonatomic) UIButton* allButton;
@property(nonatomic) NSMutableArray<FileCellvh*>* downloadList;
@end

@implementation DownloadController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.downloadList = [[NSMutableArray alloc] init];
    self.fileTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 414, 500) style:UITableViewStyleGrouped];
    [self.fileTable setDelegate:self];
    [self.fileTable setDataSource:self];
    self.fileTable.alwaysBounceVertical = YES;
    self.fileTable.userInteractionEnabled = true;
//    [self.fileTable setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.fileTable];
    self.filelistname = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 32)];
    self.filelistname.text = @"文件";
    [self.filelistname setFont:[UIFont systemFontOfSize:18] ];
    [self.view addSubview:self.filelistname];
    self.downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x-200, 520, 400, 50)];
    self.downloadButton.backgroundColor = [UIColor grayColor];
    [self.downloadButton setTitle:@"下载" forState:UIControlStateNormal];
    [self.downloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.downloadButton.layer.cornerRadius = 25;
    [self.downloadButton addTarget:self action:@selector(downloadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downloadButton];
    
    self.editButton = [[UIButton alloc] initWithFrame:CGRectMake(360, 5, 40, 24)];
    [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(editClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editButton];
    self.allButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 5, 40, 24)];
    [self.allButton setTitle:@"全选" forState:UIControlStateNormal];
    [self.allButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.allButton addTarget:self action:@selector(allClicked) forControlEvents:UIControlEventTouchUpInside];
    self.allButton.alpha = 0;
    [self.view addSubview:self.allButton];
}
-(void)downloadButtonClicked{
    
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:self.uurl parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        if(downloadProgress.fractionCompleted == 1.0f){
            dispatch_async(dispatch_get_main_queue(), ^{
                float num = downloadProgress.fractionCompleted;
                [self.cells[0] setScheduleNow:num];
            });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *createPath = [NSString stringWithFormat:@"%@/Download", documentDirectory];
        if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
        NSString* sandBoxFilePath = [NSString alloc];
        NSData* fileData = [NSData alloc];
        for(int i = 0; i<self.cells.count; ++i){
            sandBoxFilePath = [createPath stringByAppendingPathComponent:self.cells[i].file_name];
            fileData = responseObject;
            [fileData writeToFile:sandBoxFilePath atomically:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.cells.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cells[indexPath.row].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    [cell.contentView addSubview:self.cells[indexPath.row]];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.cells removeObjectAtIndex:indexPath.row];
        [self.fileTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)allClicked{
    if([self.allButton.titleLabel.text isEqualToString:@"全选"] ){
        for (int i = 0; i< self.cells.count; i++) {
          NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
          [self.fileTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
         }
        [self.allButton setTitle:@"取消" forState:UIControlStateNormal];
    }
    else{
        for (int i = 0; i< self.cells.count; i++) {
          NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
          [self.fileTable deselectRowAtIndexPath:indexPath animated:NO];
         }
        [self.allButton setTitle:@"全选" forState:UIControlStateNormal];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.downloadList addObject:self.cells[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.downloadList removeObject:self.cells[indexPath.row]];
}
- (void)editClicked{
    self.fileTable.allowsMultipleSelectionDuringEditing = YES;
//    [self.fileTable setEditing:YES animated:YES];
    self.fileTable.editing = !self.fileTable.editing;
    if(self.fileTable.editing == YES){
        [self.editButton setTitle:@"退出" forState:UIControlStateNormal];
        self.allButton.alpha = 1;
    }else{
        [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
        self.allButton.alpha = 0;
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}
@end
