
//
//  SquarePage.h
//  SYSU-TreeHole
//
//  Created by itlab on 2020/12/3.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef SquarePage_h
#define SquarePage_h

#import <UIKit/UIKit.h>
#import "Const.h"
#import "CheckRecord.h"
#import "MakeRecord.h"
#import "ContentCell.h"
#import "RequestController.h"
#import "DataController.h"

@interface SquarePage : UINavigationController

@property (nonatomic, retain) UITableView* tableView;

//用来存数据的数组
// @property (nonatomic, strong) NSMutableArray *place;
// @property (nonatomic, strong) NSMutableArray *heartget;
// @property (nonatomic, strong) NSMutableArray *userName;
// @property (nonatomic) NSMutableArray<NSInteger> *likeNum;
// @property (nonatomic) NSMutableArray<NSInteger> *commentNum;
@property (nonatomic, strong) NSMutableArray *pic;
@property (nonatomic) int num;

@end


#endif /* SquarePage_h */
