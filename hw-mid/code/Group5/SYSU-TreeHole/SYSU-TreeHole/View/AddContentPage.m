//
//  AddContentPage.m
//  PunchTheClock
//
//  Created by itlab on 2020/12/1.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddContentPage.h"

@interface AddContentPage() <UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

// content state
@property NSInteger state; // 0-none 1-album 2-app 3-movie

// list
@property NSInteger count;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *imgViews;
@property (nonatomic, strong) NSMutableArray<UIImage *> *imgs;
@property (nonatomic, strong) NSMutableArray *contentDatas;

// UI Elements
@property (nonatomic, strong) UINavigationBar *leadBar;

@property (nonatomic, strong) UITextField *contentName;

@property (nonatomic, strong) UIButton *albumBtn;
@property (nonatomic, strong) UIButton *movieBtn;
@property (nonatomic, strong) UIButton *appBtn;

@property (nonatomic, strong) UITextView *think;
@property (nonatomic, strong) UIButton *publish;
@property (nonatomic, strong) UIButton *addFile;
@property (nonatomic, strong) UIButton *back;

// net
@property (nonatomic, strong) RequestController* Request;

@end

@implementation AddContentPage

-(void) viewDidLoad
{
    [super viewDidLoad];
    _Request = [RequestController shareInstance];
    self.view.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    
    _state = 0;
    _count = 0;
    _imgs = [[NSMutableArray alloc] init];
    _imgViews = [[NSMutableArray alloc] init];
    
    _leadBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 44)];
    //创建一个导航栏集合,在这个集合Item中添加标题
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"新建内容"];
    //把导航栏集合添加到导航栏中，设置动画关闭
    [_leadBar pushNavigationItem:navItem animated:NO];
    
    [self.view addSubview:_leadBar];
    
    [self loadTitle];   // add title
    [self loadTags];    // add tag button
    [self loadThink];   // add think input
    [self loadPublish]; // add publish button
    [self loadFile];    // add file button
    [self loadBack];
    
    // [self reloadImgViews];
    [self selectAlbum];
}

-(void) loadTitle
{
    if (_contentName == nil) {
        _contentName = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 40)];
    }
    
    _contentName.textAlignment = NSTextAlignmentLeft;
    // _contentName.layer.borderColor = [UIColor.blackColor CGColor];
    // _contentName.layer.borderWidth = 1;
    _contentName.placeholder = @"Content Title";
    _contentName.font = [UIFont fontWithName:@"Arial" size:30.0];
    [self.view addSubview:_contentName];
}

-(void) loadTags
{
    float w = (self.view.frame.size.width - 80)/3;
    float h = 30;
    
    float x = self.view.frame.size.width/2 - 1.5*w - 10;
    float y = _contentName.frame.origin.y + _contentName.frame.size.height + 20;
    
    if (_albumBtn == nil) {
        _albumBtn = [[UIButton alloc] init];
        _albumBtn.frame = CGRectMake(x, y, w, h);
        
        [_albumBtn setTitle:@"Text" forState:UIControlStateNormal];
        [_albumBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _albumBtn.layer.borderWidth = 1;
        _albumBtn.layer.borderColor = [UIColor.grayColor CGColor];
        
        [_albumBtn addTarget:self action:@selector(selectAlbum) forControlEvents:UIControlEventTouchUpInside];
    }
    if (_appBtn == nil) {
        _appBtn = [[UIButton alloc] init];
        _appBtn.frame = CGRectMake(x+w+10, y, w, h);
        
        [_appBtn setTitle:@"Album" forState:UIControlStateNormal];
        [_appBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _appBtn.layer.borderWidth = 1;
        _appBtn.layer.borderColor = [UIColor.grayColor CGColor];
        
        [_appBtn addTarget:self action:@selector(selectApp) forControlEvents:UIControlEventTouchUpInside];
    }
    if (_movieBtn == nil) {
        _movieBtn = [[UIButton alloc] init];
        _movieBtn.frame = CGRectMake(x + 2*w + 20, y, w, h);
        
        [_movieBtn setTitle:@"Other" forState:UIControlStateNormal];
        [_movieBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _movieBtn.layer.borderWidth = 1;
        _movieBtn.layer.borderColor = [UIColor.grayColor CGColor];
        
        // [_movieBtn addTarget:self action:@selector(seletMovie) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.view addSubview:_albumBtn];
    [self.view addSubview:_appBtn];
    [self.view addSubview:_movieBtn];
}

-(void) selectAlbum
{
    NSLog(@"show the text");
    if (_state != 1) {
        _state = 1;
        // filter
    }
    
    _albumBtn.layer.borderColor = UIColor.blackColor.CGColor;
    [_albumBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    _appBtn.layer.borderColor = UIColor.grayColor.CGColor;
    _movieBtn.layer.borderColor = UIColor.grayColor.CGColor;
    [_appBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_movieBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void) selectApp
{
    NSLog(@"show the album");
    if (_state != 2) {
        _state = 2;
        // filter
    }
    
    _appBtn.layer.borderColor = UIColor.blackColor.CGColor;
    [_appBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    _albumBtn.layer.borderColor = UIColor.grayColor.CGColor;
    _movieBtn.layer.borderColor = UIColor.grayColor.CGColor;
    [_albumBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_movieBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void) seletMovie
{
    NSLog(@"show the other");
    if (_state != 3) {
        _state = 3;
        // filter
    }
    
    _movieBtn.layer.borderColor = UIColor.blackColor.CGColor;
    [_movieBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    _albumBtn.layer.borderColor = UIColor.grayColor.CGColor;
    _appBtn.layer.borderColor = UIColor.grayColor.CGColor;
    [_albumBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_appBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void) loadThink
{
    if (_think == nil) {
        _think = [[UITextView alloc] initWithFrame:CGRectMake(20, _contentName.frame.origin.y + 100, self.view.frame.size.width - 40, self.view.frame.size.height/4)];
    }
    
    _think.textAlignment = NSTextAlignmentLeft;
    // _think.layer.borderColor = [UIColor.blackColor CGColor];
    // _think.layer.borderWidth = 1;
    _think.text = @"Think";
    _think.textColor = UIColor.grayColor;
    _think.delegate = self;
    _think.font = [UIFont fontWithName:@"Arial" size:17.0];
    
    [self.view addSubview:_think];
}

-(void) loadPublish
{
    if (_publish == nil) {
        _publish = [[UIButton alloc] init];
    }
    
    CGFloat s = self.view.frame.size.width/13;
    _publish.frame = CGRectMake(self.view.frame.size.width - s - 30 , self.view.frame.size.height - 100 - 30, 50, s);
    
    // [_publish setBackgroundImage:[UIImage imageNamed:@"publish.png"] forState: UIControlStateNormal];
    [_publish setTitle:@"发布" forState:UIControlStateNormal];
    [_publish setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    _publish.layer.borderColor = UIColor.blackColor.CGColor;
    _publish.layer.borderWidth = 1;
    
    [_publish addTarget:self action:@selector(selectPublish) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_publish];
}

-(void) selectPublish
{
    NSLog(@"publish begin %ld", _state);
    if (_state == 1) {
        [self pubulshAsText];
    } else if (_state == 2) {
        [self pubulshAsAlbum];
    }
}

-(void) clear
{
    for (UIImageView *img in self.imgViews) {
        [img removeFromSuperview];
    }
    
    [self.imgViews removeAllObjects];
    [self.imgs removeAllObjects];
}

-(void) loadFile
{
    if (_addFile == nil) {
        _addFile = [UIButton buttonWithType:UIButtonTypeCustom];
    }

    CGFloat s = self.view.frame.size.width/13;
    _addFile.frame = CGRectMake(15 , self.view.frame.size.height - 100 - 30, s, s);
    
    [_addFile setBackgroundImage:[UIImage imageNamed:@"file.png"] forState: UIControlStateNormal];
    [_addFile addTarget:self action:@selector(selectFile) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_addFile];
}

-(void) selectFile
{
    if (_state != 2) return;
    
    
    // add file
    if (self.imgs.count >= 9) return;
    
    NSLog(@"File select");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    // get img
    
    
    // add imgview into array
    /*
    NSInteger n = self.imgs.count;
    [self.imgs addObject:[UIImage imageNamed:@"add.png"]];
    [self.imgViews addObject:[[UIImageView alloc] initWithImage:self.imgs[n]]];
    self.imgViews[n].frame = [self getNextFrame];
    [self.view addSubview:self.imgViews[n]];
    
    // set it to the true position
    [self reloadImgViews];
     */
}

-(CGRect) getNextFrame
{
    NSInteger n = _imgViews.count - 1;

    CGFloat size = self.view.frame.size.width/4;
    CGFloat br = 10 + size;
    CGFloat x = self.view.frame.size.width/8 - 10;
    CGFloat y = _think.frame.origin.y + _think.frame.size.height + 10;
    NSInteger a = n%3;
    NSUInteger b = n/3;
    
    return CGRectMake(x + a*br, y + b*br, size, size);
}

-(void) reloadImgViews
{
    NSInteger n = _imgViews.count;
    
    NSLog(@"num = %ld", n);
    
    CGFloat size = self.view.frame.size.width/4;
    CGFloat br = 10 + size;
    CGFloat x = self.view.frame.size.width/8*3 - 10;
    CGFloat y = _think.frame.origin.y + _think.frame.size.height + 10;
    
    for (int i = 0; i < n; i ++) {
        int a = i%3;
        int b = i/3;
        
        _imgViews[i].frame = CGRectMake(x + a*br, y + b*br, size, size);
    }
}

-(void) loadBack
{
    if (_back == nil) {
        _back = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    CGFloat s = self.view.frame.size.width/13;
    _back.frame = CGRectMake(15, 5, s, s);
    
    [_back setBackgroundImage:[UIImage imageNamed:@"back.png"] forState: UIControlStateNormal];
    [_back addTarget:self action:@selector(selectBack) forControlEvents:UIControlEventTouchDown];
    [_leadBar addSubview:_back];
}

-(void) selectBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate

-(void) textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length < 1) {
        textView.text = @"Think";
        textView.textColor = UIColor.grayColor;
    }
}

-(void) textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Think"]) {
        textView.text = @"";
        textView.textColor = UIColor.blackColor;
    }
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    // NSLog(@"pick 1");
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    // NSLog(@"pick 2");
    
    // NSLog(@"pick success");
    
     NSInteger n = self.imgs.count;
     [self.imgs addObject:image];
     [self.imgViews addObject:[[UIImageView alloc] initWithImage:self.imgs[n]]];
     self.imgViews[n].frame = [self getNextFrame];
     [self.view addSubview:self.imgViews[n]];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - pubulshAsText

- (void)pubulshAsText
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentAddSuccess:) name:@"contentAddTextSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentAddFailed:) name:@"contentAddTextFailed" object:nil];
    
    NSArray *arr = [[NSArray alloc] init];
    [_Request contentPostTextWithTitle:self.contentName.text detail:self.think.text tags:arr isPublic:YES];
}

- (void)contentAddSuccess:(NSNotification *)notification
{
    NSLog(@"content Add success");
    // 创建一个弹框
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"状态" message:@"发布成功" preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建 确认按钮(事件) 并添加到弹窗界面
    UIAlertAction *confirmAction =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self clear];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //添加确定按钮(事件)到弹窗
    [addAlertVC addAction:confirmAction];
    
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
}

- (void)contentAddFailed:(NSNotification *)notification
{
    NSLog(@"content Add fail");
    
    // 创建一个弹框
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"状态" message:@"发布失败" preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建 确认按钮(事件) 并添加到弹窗界面
    UIAlertAction *confirmAction =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self clear];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //添加确定按钮(事件)到弹窗
    [addAlertVC addAction:confirmAction];
    
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
}

#pragma mark - pubulshAsAlbum

- (void)pubulshAsAlbum
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentAddSuccess:) name:@"contentAddAlbumSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentAddFailed:) name:@"contentAddAlbumFailed" object:nil];
    
    NSArray *arr = [[NSArray alloc] init];
    [_Request contentAddAlbumWithTitle:self.contentName.text detail:self.think.text tags:arr isPublic:YES images:self.imgs];
}

@end
