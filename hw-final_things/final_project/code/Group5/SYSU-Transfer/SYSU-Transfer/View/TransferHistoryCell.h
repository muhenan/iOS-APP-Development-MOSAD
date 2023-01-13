//
//  TransferHistoryCell.h
//  SYSU-Transfer
//
//  Created by mac on 2021/1/6.
//  Copyright © 2021 itlab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransferHistoryCell : UITableViewCell

// page data
@property CGFloat height;
@property CGFloat width;
@property NSInteger style; // 0-comment 1-image


// file data
@property (nonatomic, strong)NSString *file_name;
@property (nonatomic, strong)NSString *file_size;
@property (nonatomic, strong)NSString *file_time;
@property (nonatomic, strong)NSString *file_id;
@property (nonatomic, strong)NSData *file_data;
@property (nonatomic, strong)UIImage *file_icon;
//@property long long file_id;

//是否下载完成，进度条情况
@property float progressOfDownload; //下载了多少，下载完成时这个值为 1

- (void)loadWithName:(NSString *)name WithData:(NSData *)data;
- (void)loadWithName:(NSString *)name WithId:(NSString *)fileID WithTime:(NSString *)time;
- (void)test:(NSInteger)type;
- (void)setOperationsTarget:(id)target WithSelector:(SEL)method;

@end

NS_ASSUME_NONNULL_END
