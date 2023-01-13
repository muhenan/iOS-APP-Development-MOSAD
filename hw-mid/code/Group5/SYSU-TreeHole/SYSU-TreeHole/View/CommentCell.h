//
//  CommentCell.h
//  SYSU-TreeHole
//
//  Created by itlab on 2020/12/9.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef CommentCell_h
#define CommentCell_h

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell

@property CGFloat height;

- (instancetype)loadCellWithComment:(NSString *)comment WithReplies:(NSMutableArray<NSString *> *)replies WithWide:(CGFloat)wide;

@end

#endif /* CommentCell_h */
