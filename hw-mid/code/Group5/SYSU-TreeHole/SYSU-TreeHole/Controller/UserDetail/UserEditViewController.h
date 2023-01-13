//
//  UserEditViewController.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef UserEditViewController_h
#define UserEditViewController_h
#import <UIKit/UIKit.h>
@interface NewTextField1 : UITextField

@end
@interface UserEditViewController : UIViewController

@property (nonatomic)NSString* name;
@property (strong, nonatomic)UITableView* detail;
@property(nonatomic)NSMutableArray* menuarray;


- (UserEditViewController*) initWithSup:(UIViewController* ) sups ;

@end

#endif /* UserEditViewController_h */
