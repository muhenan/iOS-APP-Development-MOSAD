//
//  ViewController.h
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//


#import <UIKit/UIKit.h>
#import "Const/Const.h"
#import "Page/CheckRecord.h"
#import "Page/MakeRecord.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,sender>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView* tableView;

//用来存数据的数组
@property (nonatomic, strong) NSMutableArray *time;
@property (nonatomic, strong) NSMutableArray *place;
@property (nonatomic, strong) NSMutableArray *placename;
@property (nonatomic, strong) NSMutableArray *heartget;
@property (nonatomic, strong) NSMutableArray *pic;
@property (nonatomic) int num;

//title
@property (nonatomic, strong) UINavigationBar *leadBar;
@property (nonatomic, strong) UINavigationBar *emptyBar;
@end
