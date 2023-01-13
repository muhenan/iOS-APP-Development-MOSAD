//
//  ContentCell.h
//
//
//  Created by itlab on 2020/12/3.
//

#ifndef ContentCell_h
#define ContentCell_h

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface ContentCell : UITableViewCell

- (instancetype)initWithContent:(Content *)content
                   withUserInfo:(Info *)info
                       withWide:(CGFloat)wide;

- (void)test:(NSInteger)c;

@property (nonatomic, strong) Content *content;
@property (nonatomic, strong) Info *info;
@property CGFloat cell_height;

// data
@property (nonatomic, strong) NSMutableArray<UIImage *> *imgs;

@end

#endif /* ContentCell_h */
