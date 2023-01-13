//
//  Const.h
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//

#ifndef Const_h
#define Const_h

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define RECT_NAV_HEIGHT (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)
#define TABBAR_HEIGHT self.tabBarController.tabBar.bounds.size.height

#define IMAGE_PATH_TOU [[NSBundle mainBundle] pathForResource:@"tou" ofType:@"png"]

#define IMAGE_PATH_ME [[NSBundle mainBundle] pathForResource:@"me" ofType:@"png"]
#define IMAGE_PATH_MEGRAY [[NSBundle mainBundle] pathForResource:@"megray" ofType:@"png"]
#define IMAGE_PATH_RECORD [[NSBundle mainBundle] pathForResource:@"record" ofType:@"png"]
#define IMAGE_PATH_RECORDGRAY [[NSBundle mainBundle] pathForResource:@"recordgray" ofType:@"png"]
#define IMAGE_PATH_VIEW [[NSBundle mainBundle] pathForResource:@"view" ofType:@"png"]
#define IMAGE_PATH_VIEWGRAY [[NSBundle mainBundle] pathForResource:@"viewgray" ofType:@"png"]


#endif /* Const_h */
