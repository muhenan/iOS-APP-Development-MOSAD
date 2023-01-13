//
//  OriginViewController.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef OriginViewController_h
#define OriginViewController_h
#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "LoginController.h"
#import "LoginBackground.h"

@interface OriginViewController : UIViewController

- (void)exitLogin;

- (void)login:(UserLoginInfo*) user;

- (OriginViewController*) initWithSuper:(UIViewController* ) sups ;


@end

#endif /* OriginViewController_h */
