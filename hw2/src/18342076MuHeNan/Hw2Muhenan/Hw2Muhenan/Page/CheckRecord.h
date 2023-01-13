//
//  CheckRecord.h
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//

#ifndef CheckRecord_h
#define CheckRecord_h

#import <UIKit/UIKit.h>
@interface CheckRecord : UIViewController

@property (nonatomic, strong) UILabel *labeltimeindex;
@property (nonatomic, strong) UILabel *labelplaceindex;
@property (nonatomic, strong) UILabel *labelplacenameindex;
@property (nonatomic, strong) UITextView *labelheartgetindex;

@property (nonatomic, strong) NSData* time;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, strong) NSString *placename;
@property (nonatomic, strong) NSString *heartget;
@property (nonatomic, strong) UIImage *pic1;
@property (nonatomic, strong) UIImage *pic2;
@property (nonatomic, strong) UIImage *pic3;
@property (nonatomic, strong) UIImage *pic4;
@property (nonatomic, strong) UIImage *pic5;
@property (nonatomic, strong) UIImage *pic6;

@property (nonatomic, strong) UIImage *def;
@property (nonatomic) int num;

@property (nonatomic, strong) UINavigationBar *leadBar;
@property (nonatomic, strong) UINavigationBar *emptyBar;

@property (nonatomic, strong) UIButton * buttonpic1;
@property (nonatomic, strong) UIButton * buttonpic2;
@property (nonatomic, strong) UIButton * buttonpic3;
@property (nonatomic, strong) UIButton * buttonpic4;
@property (nonatomic, strong) UIButton * buttonpic5;
@property (nonatomic, strong) UIButton * buttonpic6;

@property (nonatomic, strong) UIButton *buttonlogin;
@end


#endif /* CheckRecord_h */
