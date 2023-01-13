//
//  AwardCell.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef AwardCell_h
#define AwardCell_h
#import <UIKit/UIKit.h>
#import "AwardViewController.h"
@class AwardViewController;
@interface awardcell : UITableViewCell

@property (nonatomic)UIImageView* imageview1;
@property (nonatomic)UIImageView* imageview2;
@property (nonatomic)UIImageView* imageview3;
@property (nonatomic)UILabel* label1;
@property (nonatomic)UILabel* label2;
@property (nonatomic)UILabel* label3;
@property (strong, nonatomic)AwardViewController* acontrol;

- (void) setController:(nonnull AwardViewController*)controller;

- (void) setProperty:(nonnull UIImage*) image1 with:(nullable UIImage*)image2 with:(nullable UIImage*) image3 canClick:(NSInteger) index andlen:(NSInteger) len;
@end

#endif /* AwardCell_h */
