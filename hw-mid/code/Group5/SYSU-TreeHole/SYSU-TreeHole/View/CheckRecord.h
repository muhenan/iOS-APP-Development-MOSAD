//
//  CheckRecord.h
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//

#ifndef CheckRecord_h
#define CheckRecord_h

#import <UIKit/UIKit.h>
#import "ImgDisplay.h"
#import "DataModel.h"
#import "Comments.h"
#import "Const.h"
#import "UserDetailPage.h"

@interface CheckRecord : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) Content *content;
@property (nonatomic, strong) Info *info;
@property CGFloat cell_height;

// @property (nonatomic, strong) NSMutableArray *commentators;
// @property (nonatomic, strong) NSMutableArray *comments;

@property (nonatomic, retain) UITableView* tableView;

- (instancetype)loadWithContent:(Content *)content
                   withUserInfo:(Info *)info
                       withWide:(CGFloat)wide;

- (void)addChange;

@end

#endif /* CheckRecord_h */
