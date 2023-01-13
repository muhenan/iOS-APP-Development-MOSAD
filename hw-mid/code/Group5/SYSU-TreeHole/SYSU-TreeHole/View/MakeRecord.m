//
//  MakeRecord.m
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//

#import <Foundation/Foundation.h>
#import "MakeRecord.h"
#import "../Const.h"

@implementation MakeRecord

- (id)init
{
    self = [super init];
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
    //背景渐变
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(id)[UIColor colorWithRed:255 / 255.0 green:255/ 255.0 blue:0 / 255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:127 / 255.0 green:255 / 255.0 blue:0 / 255.0 alpha:1.0].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    */
    self.view.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:235.0/255.0 blue:232.0/255.0 alpha:1];
    
    _leadBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 44)];
    //创建一个导航栏集合,在这个集合Item中添加标题
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"发布界面"];
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
    [self.view addSubview:self.labelheartget];
    [self.view addSubview:self.labelpic];
    
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.button];
    
    [self.view addSubview:self.buttonpic1];
    [self.view addSubview:self.buttonpic2];
    [self.view addSubview:self.buttonpic3];
    [self.view addSubview:self.buttonpic4];
    [self.view addSubview:self.buttonpic5];
    [self.view addSubview:self.buttonpic6];
    [self.view addSubview:self.buttonlogin];
}

// 一些输入

// 一些输入

-(UILabel *) labelheartget{
    if (_labelheartget == nil) {
        _labelheartget = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, 60, 40)];
        _labelheartget.text = @"文案：";
        _labelheartget.textAlignment = NSTextAlignmentCenter;
        _labelheartget.adjustsFontSizeToFitWidth = YES;
    }
    return _labelheartget;
}

-(UILabel *) labelpic{
    if (_labelpic == nil) {
        _labelpic = [[UILabel alloc]initWithFrame:CGRectMake(10, 280, 60, 40)];
        _labelpic.text = @"配图：";
        _labelpic.textAlignment = NSTextAlignmentCenter;
        _labelpic.adjustsFontSizeToFitWidth = YES;
    }
    return _labelpic;
}


-(UITextView *) textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(60, 120, 250, 150)];
        _textView.layer.borderColor = [UIColor blackColor].CGColor;
        _textView.layer.borderWidth = 1.5;
        _textView.text = @"";
        _textView.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        [_textView setKeyboardType:UIKeyboardTypeDefault];
        [_textView setReturnKeyType:UIReturnKeyDone];
    }
    return _textView;
}


-(UIButton *)button{
    if (_button == nil) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-200, 60,40 )];
        [_button setShowsTouchWhenHighlighted:NO];
        [_button.layer setBorderWidth:1.0];
        [_button.layer setBorderColor:[UIColor blackColor].CGColor];
        [_button setBackgroundColor:[UIColor colorWithRed:230 / 255.0 green:230/ 255.0 blue:250 / 255.0 alpha:1.0]];
        NSString * aStr = @"发布";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]range:NSMakeRange(0,2)];
        [_button setAttributedTitle:str forState:UIControlStateNormal];
        //选中 button 后调用的函数
        [_button addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(void)sender:(UIButton*)button{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"发布成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *comfirmAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这一句是跳回广场
        self.tabBarController.selectedIndex=0;
    }];
    [alertVC addAction:comfirmAc];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    //把之前的东西都设回来
    _textView.text = @"";
    [_buttonpic1 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
    [_buttonpic2 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
    _buttonpic2.hidden = YES;
    [_buttonpic3 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
    _buttonpic3.hidden = YES;
    [_buttonpic4 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
    _buttonpic4.hidden = YES;
    [_buttonpic5 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
    _buttonpic5.hidden = YES;
    [_buttonpic6 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
    _buttonpic6.hidden = YES;

    self.view.hidden = YES;
    [self removeFromParentViewController];
    NSLog(@"aasd");
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
        _buttonpic1 = [[UIButton alloc]initWithFrame:CGRectMake(60, 280, 100,80  )];
        [_buttonpic1 setShowsTouchWhenHighlighted:NO];
        [_buttonpic1.layer setBorderWidth:1.0];
        [_buttonpic1.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonpic1 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
        [_buttonpic1 addTarget:self action:@selector(selectphoto1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonpic1;
}

-(UIButton *)buttonpic2{
    if (_buttonpic2 == nil) {
        _buttonpic2 = [[UIButton alloc]initWithFrame:CGRectMake(170, 280, 100,80 )];
        [_buttonpic2 setShowsTouchWhenHighlighted:NO];
        [_buttonpic2.layer setBorderWidth:1.0];
        [_buttonpic2.layer setBorderColor:[UIColor blackColor].CGColor];
        _buttonpic2.hidden = YES;
        [_buttonpic2 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
        [_buttonpic2 addTarget:self action:@selector(selectphoto2) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonpic2;
}

-(UIButton *)buttonpic3{
    if (_buttonpic3 == nil) {
        _buttonpic3 = [[UIButton alloc]initWithFrame:CGRectMake(280, 280, 100,80  )];
        [_buttonpic3 setShowsTouchWhenHighlighted:NO];
        [_buttonpic3.layer setBorderWidth:1.0];
        [_buttonpic3.layer setBorderColor:[UIColor blackColor].CGColor];
        _buttonpic3.hidden = YES;
        [_buttonpic3 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
        [_buttonpic3 addTarget:self action:@selector(selectphoto3) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonpic3;
}


-(UIButton *)buttonpic4{
    if (_buttonpic4 == nil) {
        _buttonpic4 = [[UIButton alloc]initWithFrame:CGRectMake(60, 380, 100,80 )];
        [_buttonpic4 setShowsTouchWhenHighlighted:NO];
        [_buttonpic4.layer setBorderWidth:1.0];
        [_buttonpic4.layer setBorderColor:[UIColor blackColor].CGColor];
        _buttonpic4.hidden = YES;
        [_buttonpic4 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
        [_buttonpic4 addTarget:self action:@selector(selectphoto4) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonpic4;
}


-(UIButton *)buttonpic5{
    if (_buttonpic5 == nil) {
        _buttonpic5 = [[UIButton alloc]initWithFrame:CGRectMake(170, 380, 100,80 )];
        [_buttonpic5 setShowsTouchWhenHighlighted:NO];
        [_buttonpic5.layer setBorderWidth:1.0];
        [_buttonpic5.layer setBorderColor:[UIColor blackColor].CGColor];
        _buttonpic5.hidden = YES;
        [_buttonpic5 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
        [_buttonpic5 addTarget:self action:@selector(selectphoto5) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonpic5;
}


-(UIButton *)buttonpic6{
    if (_buttonpic6 == nil) {
        _buttonpic6 = [[UIButton alloc]initWithFrame:CGRectMake(280, 380, 100,80 )];
        [_buttonpic6 setShowsTouchWhenHighlighted:NO];
        [_buttonpic6.layer setBorderWidth:1.0];
        [_buttonpic6.layer setBorderColor:[UIColor blackColor].CGColor];
        _buttonpic6.hidden = YES;
        [_buttonpic6 setImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] forState:UIControlStateNormal];
        [_buttonpic6 addTarget:self action:@selector(selectphoto6) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonpic6;
}

int pic1 = 0;
int pic2 = 0;
int pic3 = 0;
int pic4 = 0;
int pic5 = 0;
int pic6 = 0;

-(void)selectphoto1{
    pic1 = 1;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.delegate =self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController: imagePickerController animated:YES completion:nil];
    
}
-(void)selectphoto2{
    pic2 = 1;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.delegate =self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController: imagePickerController animated:YES completion:nil];
}
-(void)selectphoto3{
    pic3 = 1;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.delegate =self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController: imagePickerController animated:YES completion:nil];
}
-(void)selectphoto4{
    pic4 = 1;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.delegate =self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController: imagePickerController animated:YES completion:nil];
}
-(void)selectphoto5{
    pic5 = 1;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.delegate =self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController: imagePickerController animated:YES completion:nil];
}
-(void)selectphoto6{
    pic6 = 1;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.delegate =self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController: imagePickerController animated:YES completion:nil];
}




#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if(pic1 == 1){
        [self.buttonpic1 setImage:image forState:UIControlStateNormal];
        pic1 = 0;
        if (_buttonpic1.currentImage != _buttonpic2.currentImage) {
            _buttonpic2.hidden = NO;
        }
    }
    if(pic2 == 1){
        [self.buttonpic2 setImage:image forState:UIControlStateNormal];
        pic2 = 0;
        if (_buttonpic2.currentImage != _buttonpic3.currentImage) {
            _buttonpic3.hidden = NO;
        }
    }
    if(pic3 == 1){
        [self.buttonpic3 setImage:image forState:UIControlStateNormal];
        pic3 = 0;
        if (_buttonpic3.currentImage != _buttonpic4.currentImage) {
            _buttonpic4.hidden = NO;
        }
    }
    if(pic4 == 1){
        [self.buttonpic4 setImage:image forState:UIControlStateNormal];
        pic4 = 0;
        if (_buttonpic4.currentImage != _buttonpic5.currentImage) {
            _buttonpic5.hidden = NO;
        }
    }
    if(pic5 == 1){
        [self.buttonpic5 setImage:image forState:UIControlStateNormal];
        pic5 = 0;
        if (_buttonpic5.currentImage != _buttonpic6.currentImage) {
            _buttonpic6.hidden = NO;
        }
    }
    if(pic6 == 1){
        [self.buttonpic6 setImage:image forState:UIControlStateNormal];
        pic6 = 0;
    }

}



@end
