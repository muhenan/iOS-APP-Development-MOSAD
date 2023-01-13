//
//  LocalFileCell.h
//  SYSU-Transfer
//
//  Created by itlab on 2021/1/8.
//  Copyright © 2021 itlab. All rights reserved.
//

#ifndef LocalFileCell_h
#define LocalFileCell_h

#import <UIKit/UIKit.h>
#import "../Model/DataModel.h"
#import "../FileManager.h"
#import <AFNetworking/AFNetworking.h>

@interface LocalFileCell : UITableViewCell

// NEW
@property NSString *path;

// page data
@property BOOL isFloder;
@property BOOL canDelete;
@property CGFloat height;
@property CGFloat width;
@property NSInteger style; // 0-comment 1-image
@property NSInteger cell_id;

// file data
// floder content
@property (nonatomic, strong)NSString *file_name;
@property (nonatomic, strong)NSString *file_size;
@property (nonatomic, strong)NSString *file_time;
@property (nonatomic, strong)NSData *file_data;
@property (nonatomic, strong)UIImage *file_icon;
@property (nonatomic, strong)File *fileInfo;
@property BOOL isLoad;


- (void)loadWithName:(NSString *)name WithData:(NSData *)data;
- (void)getFloderWithName:(NSString *)name;
- (void)setOperationsTarget:(id)target WithSelector:(SEL)method;
- (void)rename:(NSString *)new_name;

// function
- (void)changeMark:(NSNumber *)isSelected;
- (void)loadFileData;
- (void)moveTo:(NSString *)path;

// init
- (instancetype)initWithInfo:(File *)info;
- (instancetype)initWithCell:(LocalFileCell *)cell;
- (instancetype) initMoveCellWithInfo:(File *)info;

// new
- (void)loadPage;

@end

#endif /* LocalFileCell_h */
