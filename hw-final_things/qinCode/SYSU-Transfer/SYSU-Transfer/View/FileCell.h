//
//  FileCell.h
//  SYSU-Transfer
//
//  Created by itlab on 2020/12/24.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef FileCell_h
#define FileCell_h

#import <UIKit/UIKit.h>

@interface FileCell : UITableViewCell

// page data
@property Boolean isFloder;
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

- (void)loadWithName:(NSString *)name WithData:(NSData *)data;
- (void)test:(NSInteger)type;
- (void) testFloder;
- (void)setOperationsTarget:(id)target WithSelector:(SEL)method;
- (void)rename:(NSString *)new_name;

@end

#endif /* FileCell_h */
