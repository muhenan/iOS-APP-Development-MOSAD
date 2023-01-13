//
//  Comments.h
//  Hw2Muhenan
//
//  Created by mac on 2020/12/2.
//

#ifndef Comments_h
#define Comments_h
#import <UIKit/UIKit.h>
#import "RequestController.h"
#import "CommentCell.h"

@interface Comments : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *commentators;
@property (nonatomic, strong) NSMutableArray *comments;

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic) int commentsNumber;


@property (nonatomic, strong) UINavigationBar *leadBar;
@property (nonatomic, strong) UINavigationBar *emptyBar;


@property (nonatomic, strong) UIButton *buttonlogin;

-(id)initWithID:(NSString *)ID;

@end

#endif /* Comments_h */
