//
//  UserDetailPage.h
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/29.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef UserDetailPage_h
#define UserDetailPage_h

#import <UIKit/UIKit.h>
#import "AddContentPage.h"
#import "Const.h"
#import "CheckRecord.h"
#import "MakeRecord.h"
#import "ContentCell.h"
#import "DataModel.h"
#import "DataController.h"
#import "RequestController.h"

@interface UserDetailPage : UINavigationController

@property (nonatomic, strong) UIViewController *fst;

@property (nonatomic, strong) Info *userInfo;
@property (nonatomic, strong) UserInfoRes *userRes;
@property (nonatomic, strong) NSArray<Content *> *userContents;

//用来存数据的数组
@property (nonatomic, strong) NSMutableArray *place;
@property (nonatomic, strong) NSMutableArray *heartget;
@property (nonatomic, strong) NSMutableArray *pic;
@property (nonatomic) int num;

-(void) viewDidLoad;
-(void) loadPage:(NSInteger)type;
- (void)getUserInfoByID:(NSString *)ID;

@end

#endif /* UserDetailPage_h */
