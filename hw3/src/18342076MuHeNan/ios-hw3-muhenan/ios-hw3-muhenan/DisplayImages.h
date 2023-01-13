//
//  DisplayImages.h
//  ios-hw3-muhenan
//
//  Created by mac on 2020/12/10.
//
#ifndef DISPLAYIMAGES_H
#define DISPLAYIMAGES_H

#import <UIKit/UIKit.h>

@interface DisplayImages : UIViewController<UITableViewDataSource>

@property (nonatomic, strong) UIButton *buttonLoad;
@property (nonatomic, strong) UIButton *buttonClear;
@property (nonatomic, strong) UIButton *buttonClearCache;

@property (nonatomic, strong) NSMutableArray *urls;
@property (nonatomic, strong) NSMutableArray *filePaths;

@property (nonatomic, retain) UITableView* tableView;

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@property (nonatomic) Boolean isloading;
@property (nonatomic) Boolean isclear;

@end

#endif
