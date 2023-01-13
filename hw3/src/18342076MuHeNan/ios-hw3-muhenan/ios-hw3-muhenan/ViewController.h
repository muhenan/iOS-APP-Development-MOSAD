//
//  ViewController.h
//  ios-hw3-muhenan
//
//  Created by mac on 2020/12/8.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//展示信息
@property (nonatomic, strong) UILabel *labelname;
@property (nonatomic, strong) UILabel *labelpassword;

@property (nonatomic, strong) UILabel *labellevel;
@property (nonatomic, strong) UILabel *labelemail;
@property (nonatomic, strong) UILabel *labelphone;

@property (nonatomic, strong) UITextView *textViewName;
@property (nonatomic, strong) UITextView *textViewPassword;
@property (nonatomic, strong) UITextView *textViewEmail;
@property (nonatomic, strong) UITextView *textViewPhone;

//登陆按钮
@property (nonatomic, strong) UIButton *button;
//跳转到下一个界面的按钮
@property (nonatomic, strong) UIButton *buttonToImage;

@end

