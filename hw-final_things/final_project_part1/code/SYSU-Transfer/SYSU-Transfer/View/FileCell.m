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
        _size_date.text = [[NSString alloc] initWithFormat:@"%d个文件 - %@", 2, _file_time];
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
        
        [self addSubview:_operation];
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
        
        return;
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

- (void)rename:(NSString *)new_name
{
    _file_name = new_name;
    self.name.text = new_name;
    [self loadIcon];
}

@end
