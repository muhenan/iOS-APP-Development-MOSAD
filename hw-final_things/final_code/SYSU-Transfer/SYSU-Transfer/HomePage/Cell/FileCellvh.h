//
//  FileCell.h
//  SYSU-Transfer
//
//  Created by itlab on 2020/12/24.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef FileCellvh_h
#define FileCellvh_h

#import <UIKit/UIKit.h>

@interface FileCellvh : UITableViewCell

// page data
@property CGFloat height;
@property CGFloat width;
@property NSInteger style; // 0-comment 1-image
// file data
@property (nonatomic, strong)NSString *file_name;
@property (nonatomic, strong)NSString *file_size;
@property (nonatomic, strong)NSString *file_time;
@property (nonatomic, strong)NSString *path;
@property (nonatomic, strong)NSData *file_data;
@property (nonatomic, strong)UIImage *file_icon;
@property (nonatomic, strong)UILabel *schedulel;
@property (nonatomic, strong)UIImage *finished;
@property (nonatomic, strong)UIImageView *fi;

- (void)setFi;
- (void)loadWithName:(NSString *)name WithData:(NSData *)data;
- (void)test:(NSInteger)type;
- (void)setOperationsTarget:(id)target WithSelector:(SEL)method;
- (void) loadIcon;
- (void) loadName;
- (void) loadSizeAndDate;
- (void) setScheduleNow:(float) now_schedule;
@end

#endif /* FileCell_h */
