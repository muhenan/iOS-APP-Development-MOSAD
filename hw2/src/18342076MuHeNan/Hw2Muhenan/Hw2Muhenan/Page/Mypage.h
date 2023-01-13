//
//  Mypage.h
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//

#ifndef Mypage_h
#define Mypage_h
#import <UIKit/UIKit.h>

@interface Mypage : UIViewController

//登陆 button
@property (nonatomic, strong) UIButton *button;
// title
@property (nonatomic, strong) UINavigationBar *leadBar;
@property (nonatomic, strong) UINavigationBar *emptyBar;

// 登陆后到头像
@property (nonatomic, strong) UIButton *buttonlogin;
// 用户信息
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) UILabel *label;


@end

#endif /* Mypage_h */
