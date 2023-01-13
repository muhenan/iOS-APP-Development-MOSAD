//
//  MakeRecord.h
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//

#ifndef MakeRecord_h
#define MakeRecord_h
#import <UIKit/UIKit.h>

@protocol sender <NSObject>

-(void)send:(NSArray *)arr;

@end


@interface MakeRecord : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

// 用来向 ViewController 发送信息
@property (nonatomic,weak)id <sender> delegae;

// heartget 是文案
@property (nonatomic, strong) UILabel *labelheartget;
@property (nonatomic, strong) UILabel *labelpic;

@property (nonatomic, strong) UILabel *note;//for textview


@property (nonatomic, strong) UITextView *textView;

//发布的按钮
@property (nonatomic, strong) UIButton * button;

@property (nonatomic, strong) UINavigationBar *leadBar;
@property (nonatomic, strong) UINavigationBar *emptyBar;

@property (nonatomic, strong) UIButton * buttonpic1;
@property (nonatomic, strong) UIButton * buttonpic2;
@property (nonatomic, strong) UIButton * buttonpic3;
@property (nonatomic, strong) UIButton * buttonpic4;
@property (nonatomic, strong) UIButton * buttonpic5;
@property (nonatomic, strong) UIButton * buttonpic6;


@property (nonatomic, strong) UIAlertController *alertVC;

@property (nonatomic, strong) NSArray * addarr;

//返回的按钮
@property (nonatomic, strong) UIButton *buttonlogin;
@end


#endif /* MakeRecord_h */
