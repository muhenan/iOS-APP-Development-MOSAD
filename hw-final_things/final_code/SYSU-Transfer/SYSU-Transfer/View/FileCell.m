//
//  FileCell.m
//  SYSU-Transfer
//
//  Created by itlab on 2020/12/24.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileCell.h"

@interface FileCell()

@property (nonatomic, strong)UILabel *name;
@property (nonatomic, strong)UILabel *size_date;
@property (nonatomic, strong)UIButton *operation;
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UIImageView *mark;

@property (nonatomic, strong)id target;
@property SEL method;

@end

@implementation FileCell

- (void)loadWithName:(NSString *)name WithData:(NSData *)data
{
    NSLog(@"here");
    
    self.height = 50;
    _width = self.frame.size.width;
    _style = 0;
}

- (void)test:(NSInteger)type
{
    self.height = 50;
    _width = self.frame.size.width;
    _style = 0;
    
    if (type == 1) {
        _file_name = @"12345678.txt";
    } else if (type == 2) {
        _file_name = @"test.png";
        NSURL *url = [[NSURL alloc] initWithString:@"https://hbimg.huabanimg.com/d8784bbeac692c01b36c0d4ff0e072027bb3209b106138-hwjOwX_fw658"];
        _file_data = [[NSData alloc] initWithContentsOfURL:url];
        
    } else {
        _file_name = @"other";
    }
    
    _file_time = @"2020-02-28";
    _file_size = @"19KB";
    
    [self loadName];
    [self loadIcon];
    [self loadOperation];
    [self loadSizeAndDate];
    [self loadLine];
}

- (void) testFloder
{
    _isFloder = YES;
    
    self.height = 50;
    _width = self.frame.size.width;
    _style = 0;
    _file_name = @"floder 1";
    _file_time = @"2020-02-28";
    _file_size = @"19KB";
    
    [self loadName];
    [self loadIcon];
    [self loadOperation];
    [self loadSizeAndDate];
    [self loadLine];
}

- (instancetype) initWithCell:(FileCell *)cell
{
    _isFloder = cell.isFloder;
    
    self.height = cell.height;
    _width = cell.width;
    _style = cell.style;
    _file_name = cell.file_name;
    _file_time = cell.file_time;
    _file_size = cell.file_size;
    _file_data = cell.file_data;
    _fileInfo = cell.fileInfo;
    _isLoad = cell.isLoad;
    _canDelete = cell.canDelete;
    
    [self loadName];
    [self loadIcon];
    [self loadSizeAndDate];
    [self loadLine];
    [self loadMark];
    
    return self;
}

- (instancetype) initWithInfo:(File *)info
{
    _isFloder = [info.type isEqualToString:@"FOLDER"];
    
    self.height = 50;
    _width = self.frame.size.width;
    _style = 0;
    
    _file_name = info.name;
    _file_time = @"暂无";
    _file_size = @"暂不确定";
    _file_data = nil;
    _fileInfo = info;
    
    _isLoad = NO;
    
    [self loadName];
    [self loadIcon];
    [self loadSizeAndDate];
    [self loadLine];
    [self loadOperation];
    
    // [self loadFileData];
    if ([_fileInfo.type isEqualToString:@"FOLDER"]) {
        [self loadChild];
    }
    return self;
}

- (instancetype) initMoveCellWithInfo:(File *)info
{
    _isFloder = [info.type isEqualToString:@"FOLDER"];
    
    self.height = 50;
    _width = self.frame.size.width;
    _style = 0;
    
    _file_name = info.name;
    _file_time = @"暂无";
    _file_size = @"暂不确定";
    _file_data = nil;
    _fileInfo = info;
    
    _isLoad = NO;
    
    [self loadName];
    [self loadIcon];
    [self loadSizeAndDate];
    [self loadLine];
    
    return self;
}

- (void)loadChild
{
    extern AFHTTPSessionManager *httpManager;
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@", @"/folders", self.fileInfo.fullPath];
    
    [httpManager POST:url
           parameters:@{
                        }
              headers:nil
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                  // NSLog(@"Folder %@ get success", node.fullPath);
                  // NSLog(@"child object = %@", responseObject);
                  
                  File* tmp = [File dic2Object:responseObject];
                  self.fileInfo.children = [[NSMutableArray alloc] initWithArray:tmp.children];
                  self.size_date.text = [[NSString alloc] initWithFormat:@"%ld个文件", self.fileInfo.children.count];
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                  // NSLog(@"Folder %@ get fail", node.fullPath);
              }];
}

- (void) loadName
{
    if (_name == nil) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(50, 7, _width-80, 20)];
        [_name setTextAlignment:NSTextAlignmentLeft];
        _name.font = [UIFont systemFontOfSize:15];
        _name.textColor = UIColor.blackColor;
        
        [self addSubview:_name];
    }
    _name.text = _file_name;
    if ([_file_name length] >= 15) {
        _name.font = [UIFont systemFontOfSize:8];
    }
}

- (void) loadSizeAndDate
{
    if (_size_date == nil) {
        _size_date = [[UILabel alloc] initWithFrame:CGRectMake(50, 28, _width-80, 15)];
        [_size_date setTextAlignment:NSTextAlignmentLeft];
        _size_date.font = [UIFont systemFontOfSize:12];
        _size_date.textColor = UIColor.grayColor;
        
        [self addSubview:_size_date];
    }
    if (_isFloder)
        _size_date.text = [[NSString alloc] initWithFormat:@"%ld个文件 - %@", self.fileInfo.children.count, _file_time];
    else
        _size_date.text = [[NSString alloc] initWithFormat:@"%@ - %@", _file_size, _file_time];
}

- (void) loadOperation
{
    if (_operation == nil) {
        _operation = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-20, 15, 20, 20)];
        _operation.contentMode = UIViewContentModeScaleAspectFit;
        
        [_operation setBackgroundImage:[UIImage imageNamed:@"operation.png"] forState:UIControlStateNormal];
        [_operation addTarget:self action:@selector(selectOperations) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_operation];
    }
}

- (void) loadIcon
{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_icon];
    }
    
    if (_isFloder) {
        _file_icon = [UIImage imageNamed:@"floder.png"];
        _icon.image = _file_icon;
        _style = 0;
        
        return;
    }
    
    if ([_file_name hasSuffix:@"png"] || [_file_name hasSuffix:@"jpg"] || [_file_name hasSuffix:@"bmp"] || [_file_name hasSuffix:@"jpeg"]){
        // NSLog(@"file id = %ld", self.fileInfo.ID);
        
        if (! _isLoad)
            [self loadFileData];
        
        _style = 1;
    } else if ([_file_name hasSuffix:@"pdf"]) {
        _file_icon = [UIImage imageNamed:@"pdf.png"];
        _style = 2;
    } else if ([_file_name hasSuffix:@"doc"] || [_file_name hasSuffix:@"docx"]) {
        _file_icon = [UIImage imageNamed:@"doc.png"];
        _style = 3;
    } else if ([_file_name hasSuffix:@"txt"]) {
        _file_icon = [UIImage imageNamed:@"txt.png"];
        _style = 4;
    } else if ([_file_name hasSuffix:@"ppt"] || [_file_name hasSuffix:@"pptx"]) {
        _file_icon = [UIImage imageNamed:@"ppt.png"];
        _style = 5;
    } else if ([_file_name hasSuffix:@"xls"] || [_file_name hasSuffix:@"xlsx"]) {
        _file_icon = [UIImage imageNamed:@"xls.png"];
        _style = 6;
    } else if ([_file_name hasSuffix:@"zip"] || [_file_name hasSuffix:@"tar"]) {
        _file_icon = [UIImage imageNamed:@"zip.png"];
        _style = 7;
    } else {
        _file_icon = [UIImage imageNamed:@"other.png"];
        _style = 8;
    }
    
    _icon.image = _file_icon;
}

- (void)selectOperations
{
    NSLog(@"select operations");
    
    // 调用父类的函数
    [_target performSelector:_method withObject:self afterDelay:0];
}

- (void)setOperationsTarget:(id)target WithSelector:(SEL)method
{
    _target = target;
    _method = method;
}

- (void)loadLine
{
    // line len
    CGFloat len = 45;
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(len, _height-3, _width-len, 1)];
    line.layer.borderColor = UIColor.grayColor.CGColor;
    line.layer.borderWidth = 0.5;
    
    [self addSubview:line];
}

- (void)rename:(NSString *)new_name
{
    _file_name = new_name;
    self.name.text = new_name;
    [self loadIcon];
}


- (void)getFloderWithName:(NSString *)name
{
    _isFloder = YES;
    
    self.height = 50;
    _width = self.frame.size.width;
    _style = 0;
    _file_name = name;
    _file_time = @"2020-02-28";
    _file_size = @"19KB";
    
    [self loadName];
    [self loadIcon];
    [self loadOperation];
    [self loadSizeAndDate];
    [self loadLine];
}

- (void)loadMark
{
    self.canDelete = (self.isFloder && self.fileInfo.children.count == 0) || !self.isFloder;
    if (_mark == nil && self.canDelete) {
        _mark = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-20, 15, 20, 20)];
        [_mark setImage:[UIImage imageNamed:@"unselected.png"]];
        
        [self addSubview:_mark];
    }
}

- (void)changeMark:(NSNumber *)isSelected
{
    if ([isSelected boolValue]) {
        [_mark setImage:[UIImage imageNamed:@"selected.png"]];
    } else {
        [_mark setImage:[UIImage imageNamed:@"unselected.png"]];
    }
}

- (void)loadFileData
{
    extern AFHTTPSessionManager *loadManager;
    NSString *url = [[NSString alloc] initWithFormat:@"/files/%ld/download", self.fileInfo.ID];
    // NSString *url = [[NSString alloc] initWithFormat:@"/files/10/download"];
    
    [loadManager GET:url
           parameters:@{
                        }
              headers:nil
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                  // NSLog(@"url = %@", url);
                  // NSLog(@"get file data = %@", responseObject);
                  
                  self.file_data = [[NSData alloc] initWithData:responseObject];
                  if (self.style == 1) {
                      self.icon.image = [UIImage imageWithData:self.file_data];
                  }
                  
                  self.file_size = [[NSString alloc] initWithFormat:@"%ld", [self.file_data length]];
                  self.isLoad = YES;
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                  //NSLog(@"get file(%@) data fail, err=%@", url, error);
                  
                  self.isLoad = NO;
                  self.style = 8;
                  self.icon.image = [UIImage imageNamed:@"other.png"];
              }];
}

- (void)moveTo:(NSString *)path
{
    NSLog(@"%@ move to %@", self.file_name, path);
    
    __block NSString *fullpath = [[NSString alloc] initWithFormat:@"%@%@", path, self.fileInfo.name];
    
    extern AFHTTPSessionManager *loadManager;
    NSString *url = [[NSString alloc] initWithFormat:@"/files/%ld/download", self.fileInfo.ID];
    // NSString *url = [[NSString alloc] initWithFormat:@"/files/10/download"];
    
    [loadManager GET:url
          parameters:@{
                       }
             headers:nil
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                 // NSLog(@"url = %@", url);
                 // NSLog(@"get file data = %@", responseObject);
                 
                 // INIT
                 AFHTTPSessionManager* manager =[AFHTTPSessionManager manager];
                 manager.requestSerializer.timeoutInterval = 20;
                 manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
                 NSString* url = @"http://222.200.161.218:8080/files/";
                 
                 
                 // upload
                 __block NSData *data = [[NSData alloc] initWithData:responseObject];
                 __block NSData *goal = [[[NSString alloc] initWithString:fullpath] dataUsingEncoding:NSUTF8StringEncoding];
                 
                 NSLog(@"data begin upload");
                 [manager POST:url parameters:nil headers:nil
     constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                             [formData appendPartWithFileData:data name:@"file" fileName:self.file_name mimeType:@"multipart/form-data"];
                             [formData appendPartWithFormData:goal name:@"fullPath"];
                         }
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             NSLog(@"success %@", responseObject);
                         }
                       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             NSLog(@"%@", error);
                         }];
                 
                 
                 // delete
                 extern AFHTTPSessionManager *httpManager;
                 File *target = self.fileInfo;
                 BOOL realFolder = self.isFloder;
                 
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
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                 //NSLog(@"get file(%@) data fail, err=%@", url, error);
                 NSLog(@"can't get file");
             }];
}

- (void)download
{
    extern AFHTTPSessionManager *loadManager;
    NSString *url = [[NSString alloc] initWithFormat:@"/files/%ld/download", self.fileInfo.ID];
    // NSString *url = [[NSString alloc] initWithFormat:@"/files/10/download"];
    
    [loadManager GET:url
          parameters:@{
                       }
             headers:nil
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                 // NSLog(@"url = %@", url);
                 // NSLog(@"get file data = %@", responseObject);
                 
                 self.file_data = [[NSData alloc] initWithData:responseObject];
                 NSString *path = [[NSString alloc] initWithFormat:@"%@%@", @"", self.file_name];
                 [FileManager WriteFile:self.file_data ByName:path];
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                 //NSLog(@"get file(%@) data fail, err=%@", url, error);
                 
                 self.isLoad = NO;
                 self.style = 8;
                 self.icon.image = [UIImage imageNamed:@"other.png"];
             }];
}

@end
