//
//  TransferHistoryCell.m
//  SYSU-Transfer
//
//  Created by mac on 2021/1/6.
//  Copyright © 2021 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransferHistoryCell.h"


@interface TransferHistoryCell()

@property (nonatomic, strong)UILabel *name;
@property (nonatomic, strong)UILabel *size_date;
@property (nonatomic, strong)UILabel *label_share_id;
@property (nonatomic, strong)UIButton *operation;
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UIProgressView *downloadProgressView; // 进度条

@property (nonatomic, strong)id target;
@property SEL method;

@end

@implementation TransferHistoryCell

- (void)loadWithName:(NSString *)name WithData:(NSData *)data
{
    NSLog(@"here");
    
    self.height = 70;
    _width = self.frame.size.width;
    _style = 0;
}

- (void)loadWithName:(NSString *)name WithId:(NSString *)fileID WithTime:(NSString *)time
{
    NSLog(@"here");
    
    self.height = 70;
    _width = self.frame.size.width;
    _style = 0;
    
    _file_name = name;
    NSRange range = NSMakeRange(10,1);
    _file_time = [time stringByReplacingCharactersInRange:range withString:@"  "];
    _file_id = fileID;
    
    [self loadName];
    [self loadIcon];
    [self loadOperation];
    [self loadSizeAndDate];
    [self loadShareId];
    [self loadLine];
}

- (void)test:(NSInteger)type
{
    self.height = 70;
    _width = self.frame.size.width;
    _style = 0;
    
    if (type == 1) {
        _file_name = @"12345678.txt";
        _file_time = @"2020-12-28";
        _progressOfDownload = 0.7;
    } else if (type == 2) {
        _file_name = @"test.png";
        _progressOfDownload = 0.3;
        NSURL *url = [[NSURL alloc] initWithString:@"https://hbimg.huabanimg.com/d8784bbeac692c01b36c0d4ff0e072027bb3209b106138-hwjOwX_fw658"];
        _file_data = [[NSData alloc] initWithContentsOfURL:url];
        _file_time = @"2020-12-27";
    } else {
        _progressOfDownload = 1;
        _file_name = @"other";
        _file_time = @"2020-12-26";
    }
    
    //_file_time = @"2020-02-28";
    _file_size = @"19KB";
    _file_id = @"2";
    
    [self loadName];
    [self loadIcon];
    [self loadOperation];
//    if(self.progressOfDownload == 1){
//        [self loadSizeAndDate];
//    }else{
//        [self loadProgress];
//    }
    [self loadSizeAndDate];
    [self loadShareId];
    [self loadLine];
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
}

- (void) loadProgress
{
    if (_downloadProgressView == nil){
        _downloadProgressView = [[UIProgressView alloc] init];
        _downloadProgressView.frame = CGRectMake(50, 31, _width-80, 15);
        
        _downloadProgressView.progressViewStyle = UIProgressViewStyleDefault;
        _downloadProgressView.progressTintColor = UIColor.greenColor;
        _downloadProgressView.trackTintColor = UIColor.grayColor;
        
        _downloadProgressView.progress = 0;
        NSLog(@"progress Of Download is %fl", self.progressOfDownload);
        [_downloadProgressView setProgress:self.progressOfDownload animated:YES];
        
        [self addSubview:_downloadProgressView];
        
//        _store = [[UIProgressView alloc] init];
//        _store.frame = CGRectMake(x, _upBar.frame.size.height + _upBar.frame.origin.y + 5, _width-2*x, 20);
//
//        _store.progressViewStyle = UIProgressViewStyleDefault;
//        _store.progressTintColor = UIColor.greenColor;
//        _store.trackTintColor = UIColor.grayColor;
//
//
//        _store.progress = 0;
//        [_store setProgress:0.5 animated:YES];
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
    _size_date.text = [[NSString alloc] initWithFormat:@"%@",_file_time];
}

- (void) loadShareId
{
    if(_label_share_id == nil){
        _label_share_id = [[UILabel alloc] initWithFrame:CGRectMake(50, 44, _width - 80, 15)];
        [_label_share_id setTextAlignment:NSTextAlignmentLeft];
        _label_share_id.font = [UIFont systemFontOfSize:12];
        _label_share_id.textColor = UIColor.grayColor;
        
        [self addSubview:_label_share_id];
    }
    _label_share_id.text = [[NSString alloc] initWithFormat:@"Share id: %@", _file_id];
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
    
    if ([_file_name hasSuffix:@"png"] || [_file_name hasSuffix:@"jpg"] || [_file_name hasSuffix:@"bmp"]){
        _file_icon = [UIImage imageWithData:_file_data];
        _style = 1;
    } else if ([_file_name hasSuffix:@"pdf"]) {
        _file_icon = [UIImage imageNamed:@"pdf.png"];
    } else if ([_file_name hasSuffix:@"doc"] || [_file_name hasSuffix:@"docx"]) {
        _file_icon = [UIImage imageNamed:@"doc.png"];
    } else if ([_file_name hasSuffix:@"txt"]) {
        _file_icon = [UIImage imageNamed:@"txt.png"];
    } else if ([_file_name hasSuffix:@"ppt"] || [_file_name hasSuffix:@"pptx"]) {
        _file_icon = [UIImage imageNamed:@"ppt.png"];
    } else if ([_file_name hasSuffix:@"xls"] || [_file_name hasSuffix:@"xlsx"]) {
        _file_icon = [UIImage imageNamed:@"xls.png"];
    } else if ([_file_name hasSuffix:@"zip"] || [_file_name hasSuffix:@"tar"]) {
        _file_icon = [UIImage imageNamed:@"zip.png"];
    } else {
        _file_icon = [UIImage imageNamed:@"other.png"];
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

@end
