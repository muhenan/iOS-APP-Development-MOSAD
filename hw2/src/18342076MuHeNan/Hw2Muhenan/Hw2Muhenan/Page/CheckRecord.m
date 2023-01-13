//
//  CheckRecord.m
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//

#import <Foundation/Foundation.h>
#import "CheckRecord.h"
#import "../Const/Const.h"

@implementation CheckRecord

-(id)init{
    self = [super init];
    _def = [UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY];
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //背景渐变
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(id)[UIColor colorWithRed:255 / 255.0 green:255/ 255.0 blue:0 / 255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:127 / 255.0 green:255 / 255.0 blue:0 / 255.0 alpha:1.0].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    _leadBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 44)];
    //创建一个导航栏集合,在这个集合Item中添加标题
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"查看打卡"];
    //把导航栏集合添加到导航栏中，设置动画关闭
    [_leadBar pushNavigationItem:navItem animated:NO];
    //将标题栏中的内容全部添加到主视图当中
    
    
    _emptyBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //创建一个导航栏集合,在这个集合Item中添加标题
    UINavigationItem *avItem = [[UINavigationItem alloc] initWithTitle:@""];
    //把导航栏集合添加到导航栏中，设置动画关闭
    [_emptyBar pushNavigationItem:avItem animated:NO];
    
    [_emptyBar setShadowImage:[UIImage new]];
    //将标题栏中的内容全部添加到主视图当中
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_emptyBar];
    [self.view addSubview:_leadBar];
    [self.view addSubview:self.labeltimeindex];
    [self.view addSubview:self.labelplaceindex];
    [self.view addSubview:self.labelheartgetindex];
    [self.view addSubview:self.labelplacenameindex];
    [self.view addSubview:self.buttonlogin];
    
    
    [self.view addSubview:self.buttonpic1];
    [self.view addSubview:self.buttonpic2];
    [self.view addSubview:self.buttonpic3];
    [self.view addSubview:self.buttonpic4];
    [self.view addSubview:self.buttonpic5];
    [self.view addSubview:self.buttonpic6];
    
    if (_pic6 == _def) {
        _buttonpic6.hidden = YES;
    }
    if (_pic5 == _def) {
        _buttonpic5.hidden = YES;
    }
    if (_pic4 == _def) {
        _buttonpic4.hidden = YES;
    }
    if (_pic3 == _def) {
        _buttonpic3.hidden = YES;
    }
    if (_pic2 == _def) {
        _buttonpic2.hidden = YES;
    }
    if (_pic1 == _def) {
        _buttonpic1.hidden = YES;
    }
    
}

-(UILabel *) labeltimeindex{
    if (_labeltimeindex == nil) {
        _labeltimeindex = [[UILabel alloc]initWithFrame:CGRectMake(50, 115, 300, 30)];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        _labeltimeindex.text = [[NSString alloc] initWithFormat:@"%@", [dateFormatter stringFromDate:_time]];
        _labeltimeindex.textAlignment = NSTextAlignmentLeft;
        _labeltimeindex.adjustsFontSizeToFitWidth = YES;
        _labeltimeindex.layer.borderColor = [UIColor grayColor].CGColor;
        _labeltimeindex.layer.borderWidth = 0.5;
    }
    return _labeltimeindex;
}

-(UILabel *) labelplaceindex{
    if (_labelplaceindex == nil) {
        _labelplaceindex = [[UILabel alloc]initWithFrame:CGRectMake(50, 155, 300, 30)];
        _labelplaceindex.text = [[NSString alloc] initWithFormat:@"%@", _place];
        _labelplaceindex.textAlignment = NSTextAlignmentLeft;
        _labelplaceindex.adjustsFontSizeToFitWidth = YES;
        _labelplaceindex.layer.borderColor = [UIColor grayColor].CGColor;
        _labelplaceindex.layer.borderWidth = 0.5;
    }
    return _labelplaceindex;
}

-(UILabel *) labelplacenameindex{
    if (_labelplacenameindex == nil) {
        _labelplacenameindex = [[UILabel alloc]initWithFrame:CGRectMake(50, 195, 300, 30)];
        _labelplacenameindex.text = [[NSString alloc] initWithFormat:@"%@",_placename];
        _labelplacenameindex.textAlignment = NSTextAlignmentLeft;
        _labelplacenameindex.adjustsFontSizeToFitWidth = YES;
        _labelplacenameindex.layer.borderColor = [UIColor grayColor].CGColor;
        _labelplacenameindex.layer.borderWidth = 0.5;
    }
    return _labelplacenameindex;
}

-(UITextView *) labelheartgetindex{
    if (_labelheartgetindex == nil) {
        _labelheartgetindex = [[UITextView alloc]initWithFrame:CGRectMake(50, 245, 300, 180)];
        _labelheartgetindex.text = [[NSString alloc] initWithFormat:@"%@",_heartget];
        _labelheartgetindex.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        //_labelheartgetindex.adjustsFontSizeToFitWidth = YES;
        _labelheartgetindex.layer.borderColor = [UIColor grayColor].CGColor;
        _labelheartgetindex.layer.borderWidth = 0.5;
    }
    return _labelheartgetindex;
}



-(UIButton *)buttonlogin{
    if (_buttonlogin == nil) {
        _buttonlogin = [[UIButton alloc]initWithFrame:CGRectMake(25, 45, 40,40 )];
        [_buttonlogin setShowsTouchWhenHighlighted:NO];
        
        [_buttonlogin.layer setBorderWidth:1.0];
        [_buttonlogin.layer setBorderColor:[UIColor grayColor].CGColor];
        [_buttonlogin.layer setCornerRadius:20.0];
         
        [_buttonlogin addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString * aStr = @"返回";
         NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
         [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]range:NSMakeRange(0,2)];
         [_buttonlogin setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _buttonlogin;
}

-(void)btnClick:(id) sender{
    self.view.hidden = YES;
    [self removeFromParentViewController];
    NSLog(@"aasd");
}

-(UIButton *)buttonpic1{
    if (_buttonpic1 == nil) {
        _buttonpic1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 460, 100,80  )];
        [_buttonpic1 setShowsTouchWhenHighlighted:NO];
        [_buttonpic1.layer setBorderWidth:1.0];
        [_buttonpic1.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonpic1 setImage:_pic1 forState:UIControlStateNormal];
    }
    return _buttonpic1;
}

-(UIButton *)buttonpic2{
    if (_buttonpic2 == nil) {
        _buttonpic2 = [[UIButton alloc]initWithFrame:CGRectMake(160, 460, 100,80 )];
        [_buttonpic2 setShowsTouchWhenHighlighted:NO];
        [_buttonpic2.layer setBorderWidth:1.0];
        [_buttonpic2.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonpic2 setImage:_pic2 forState:UIControlStateNormal];

    }
    return _buttonpic2;
}

-(UIButton *)buttonpic3{
    if (_buttonpic3 == nil) {
        _buttonpic3 = [[UIButton alloc]initWithFrame:CGRectMake(270, 460, 100,80  )];
        [_buttonpic3 setShowsTouchWhenHighlighted:NO];
        [_buttonpic3.layer setBorderWidth:1.0];
        [_buttonpic3.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonpic3 setImage:_pic3 forState:UIControlStateNormal];

    }
    return _buttonpic3;
}


-(UIButton *)buttonpic4{
    if (_buttonpic4 == nil) {
        _buttonpic4 = [[UIButton alloc]initWithFrame:CGRectMake(50, 550, 100,80 )];
        [_buttonpic4 setShowsTouchWhenHighlighted:NO];
        [_buttonpic4.layer setBorderWidth:1.0];
        [_buttonpic4.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonpic4 setImage:_pic4 forState:UIControlStateNormal];

    }
    return _buttonpic4;
}


-(UIButton *)buttonpic5{
    if (_buttonpic5 == nil) {
        _buttonpic5 = [[UIButton alloc]initWithFrame:CGRectMake(160, 550, 100,80 )];
        [_buttonpic5 setShowsTouchWhenHighlighted:NO];
        [_buttonpic5.layer setBorderWidth:1.0];
        [_buttonpic5.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonpic5 setImage:_pic5 forState:UIControlStateNormal];

    }
    return _buttonpic5;
}


-(UIButton *)buttonpic6{
    if (_buttonpic6 == nil) {
        _buttonpic6 = [[UIButton alloc]initWithFrame:CGRectMake(270, 550, 100,80 )];
        [_buttonpic6 setShowsTouchWhenHighlighted:NO];
        [_buttonpic6.layer setBorderWidth:1.0];
        [_buttonpic6.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonpic6 setImage:_pic6 forState:UIControlStateNormal];
    }
    return _buttonpic6;
}

@end
