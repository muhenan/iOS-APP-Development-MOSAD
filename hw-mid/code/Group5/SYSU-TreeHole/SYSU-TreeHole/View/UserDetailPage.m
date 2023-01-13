//
//  UserDetailPage.m
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/29.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDetailPage.h"

@interface UserDetailPage() <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

// content state
@property NSInteger state; // 0-all 1-album 2-app 3-movie

// right
@property NSInteger right;

// layout
@property CGFloat upBound;
@property CGFloat midBound;
@property CGFloat downBound;

// UI elements
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIImageView *userImg;
@property (nonatomic, strong) UITableView *contents; // three types: ablum app movie

@property (nonatomic, strong) UILabel *userBio;
@property (nonatomic, strong) UILabel *userContentNum;
@property (nonatomic, strong) UIButton *userName;

@property (nonatomic, strong) UIButton *addContentBtn;

@property (nonatomic, strong) UIButton *albumBtn;
@property (nonatomic, strong) UIButton *textBtn;
@property (nonatomic, strong) UIButton *otherBtn;
@property (nonatomic, strong) UITableView *table;

// net
@property (nonatomic, strong) RequestController *Request;
@property (nonatomic, strong) NSString *tmpName;

// data set
@property (nonatomic, strong) NSMutableArray<ContentCell *> *textCells;
@property (nonatomic, strong) NSMutableArray<ContentCell *> *albumCells;
@property (nonatomic, strong) NSMutableArray<ContentCell *> *otherCells;

@property (nonatomic, strong) ContentRes *textContents;
@property (nonatomic, strong) ContentRes *albumContents;
@property (nonatomic, strong) ContentRes *otherContents;

@end

@implementation UserDetailPage

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    _textCells = [[NSMutableArray alloc] init];
    _albumCells = [[NSMutableArray alloc] init];
    _otherCells = [[NSMutableArray alloc] init];
    
    _Request = [RequestController shareInstance];
    _fst = [[UIViewController alloc] init];
    _fst.view.backgroundColor = UIColor.whiteColor;
    // _fst.view.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    // [self setNavigationBarHidden:YES animated:YES];
    _fst.navigationItem.title = @"用户信息";
    [self pushViewController:_fst animated:YES];
    
    [self selectText];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getInfoSuccess:) name:@"userGetSelfInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getInfoFailed:) name:@"userGetSelfInfoFailed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getInfoSuccess:) name:@"userInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getInfoFailed:) name:@"userInfoFailed" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentGetTextSuccess:) name:@"contentGetTextSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentGetTextFailed:) name:@"contentGetTextFailed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentGetAlbumSuccess:) name:@"contentGetAlbumSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentGetAlbumFailed:) name:@"contentGetAlbumFailed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userUpdateSuccess:) name:@"userUpdateSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userUpdateFailed:) name:@"userUpdateFailed" object:nil];
}

- (void)reloadPage
{
    [_userName setTitle:_userInfo.name forState:UIControlStateNormal];
    // _userName.titleLabel.text = _userInfo.name;
    _userContentNum.text = [[NSString alloc] initWithFormat:@"%ld", _textCells.count + _albumCells.count + _otherCells.count];
    
    if ([_userInfo.bio isEqualToString:@""]) {
        _userBio.text = @"这个人很懒，暂时没有个性签名";
    } else {
        _userBio.text = _userInfo.bio;
    }
    
    [self getTextContent];
    [self getAlbumContent];
}

// self
- (void)getSelfInfo
{
    
    NSLog(@"begin get self info");
    [_Request userGetSelfInfo];
    NSLog(@"end get self info");
}

-(void) loadPage:(NSInteger)type
{
    // if user can edit the contents
    _right = type;
    
    // layout
    _upBound = self.view.frame.size.height/4;
    
    [self loadBackgroud];
    [self loadUserImg];
    [self loadUserDetail];
    
    _downBound = _midBound - 10;
    if (_right == 0) {
        // can edit
        [self loadAddButton];
        [self getSelfInfo];
    }
    
    [self loadCutLine];
    [self loadThreeBtn];
    [self loadContentTable];
}

-(void) loadCutLine
{
    // cut line
    UILabel *label = [[UILabel alloc] init];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"__________________________________________"];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    label.attributedText = content;
    
    [label sizeToFit];
    label.frame = CGRectMake(self.view.frame.size.width/2-label.frame.size.width/2, _downBound-3, label.frame.size.width, label.frame.size.height);
    label.textColor = UIColor.grayColor;
    
    _downBound += 15;
    [_fst.view addSubview:label];
}

// up
-(void) loadBackgroud
{
    UIImage *pic = [UIImage imageNamed:@"background.jpg"];
    _background = [[UIImageView alloc] initWithImage:pic];
    
    _background.frame = CGRectMake(0, 0, self.view.frame.size.width, _upBound);
    [_fst.view addSubview:_background];
}

-(void) loadUserImg
{
    UIImage *pic = [UIImage imageNamed:@"background.jpg"];
    _userImg = [[UIImageView alloc] initWithImage:pic];
    
    float w = self.view.frame.size.width/3.5;
    float x = self.view.frame.size.width/2 - w/2;
    float y = _upBound - w/2;
    
    _userImg.frame = CGRectMake(x, y, w, w);
    _userImg.layer.borderColor = [[UIColor whiteColor] CGColor];
    _userImg.layer.borderWidth = 2;
    _userImg.layer.cornerRadius = w/2;
    
    _userImg.clipsToBounds = YES;
    
    [_fst.view addSubview:_userImg];
}

// mid
-(void) loadUserDetail
{
    [self loadUserName];
    [self loadContentNum];
    [self loadBio];
    
    _midBound = _userBio.frame.origin.y + _userBio.frame.size.height + 5;
}

-(void) loadUserName
{
    if (_userName == nil) {
        _userName = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 110, 25)];
    }
    
    [_userName setTitle:@"qin" forState:UIControlStateNormal];
    [_userName setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    _userName.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _userName.backgroundColor = UIColor.clearColor;
    [_userName addTarget:self action:@selector(changeName) forControlEvents:UIControlEventTouchUpInside];
    // _userName.titleLabel.textColor = UIColor.blackColor;
    
    // _userName.layer.borderWidth = 1;
    // _userName.layer.borderColor = UIColor.grayColor.CGColor;
    // [_userName sizeToFit];
    
    float x = self.view.frame.size.width/4 - _userImg.frame.size.width/4 - _userName.frame.size.width/2 ;
    float y = _upBound + _userName.frame.size.height;
    _userName.frame = CGRectMake(x, y, _userName.frame.size.width, _userName.frame.size.height);
    
    [_fst.view addSubview:_userName];
    
    UILabel *tag = [[UILabel alloc] init];
    tag.text = @"用户名";
    tag.font = [UIFont boldSystemFontOfSize:13];
    tag.textColor = UIColor.grayColor;
    [tag sizeToFit];
    
    tag.frame = CGRectMake(self.view.frame.size.width/4 - _userImg.frame.size.width/4 - tag.frame.size.width/2 , y + 25, tag.frame.size.width, tag.frame.size.height);
    [_fst.view addSubview:tag];
}

-(void) loadContentNum
{
    if (_userContentNum == nil) {
        _userContentNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110, 25)];
    }
    
    _userContentNum.text = @"10";
    _userContentNum.font = [UIFont boldSystemFontOfSize:20];
    [_userContentNum setTextAlignment:UITextAlignmentCenter];
    // [_userContentNum sizeToFit];
    
    float x = self.view.frame.size.width/4 *3 + _userImg.frame.size.width/4 - _userContentNum.frame.size.width/2 ;
    float y = _upBound + _userContentNum.frame.size.height;
    _userContentNum.frame = CGRectMake(x, y, _userContentNum.frame.size.width, _userContentNum.frame.size.height);
    
    [_fst.view addSubview:_userContentNum];
    
    UILabel *tag = [[UILabel alloc] init];
    tag.text = @"发布量";
    tag.font = [UIFont boldSystemFontOfSize:13];
    tag.textColor = UIColor.grayColor;
    [tag sizeToFit];
    
    tag.frame = CGRectMake(self.view.frame.size.width/4 *3 + _userImg.frame.size.width/4 - tag.frame.size.width/2 , y + 25, tag.frame.size.width, tag.frame.size.height);
    [_fst.view addSubview:tag];
}

-(void) loadBio
{
    if (_userBio == nil) {
        _userBio = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 380, 20)];
    }
    
    // _userBio.layer.borderWidth = 1;
    // _userBio.layer.borderColor = UIColor.grayColor.CGColor;
    _userBio.text = @"这是个性签名哟～";
    _userBio.font = [UIFont boldSystemFontOfSize:16];
    [_userBio setTextAlignment:UITextAlignmentCenter];
    
    float x = self.view.frame.size.width/2 - _userBio.frame.size.width/2 ;
    float y = _upBound + _userBio.frame.size.height + _userImg.frame.size.height/2 + 5;
    _userBio.frame = CGRectMake(x, y, _userBio.frame.size.width, _userBio.frame.size.height);
    
    [_fst.view addSubview:_userBio];
}

// down
-(void) loadAddButton
{
    if (_addContentBtn == nil) {
        _addContentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    CGFloat s = self.view.frame.size.width/13;
    _addContentBtn.frame = CGRectMake(self.view.frame.size.width - s - 15 , 140, s, s);
    
    // _addContentBtn.backgroundColor = UIColor.blackColor;
    [_addContentBtn setBackgroundImage:[UIImage imageNamed:@"add2.png"] forState: UIControlStateNormal];
    [_addContentBtn addTarget:self action:@selector(selectAdd) forControlEvents:UIControlEventTouchDown];
    [_fst.view addSubview:_addContentBtn];
}

-(void) selectAdd
{
    NSLog(@"select add 1");
    
    AddContentPage *add = [[AddContentPage alloc] init];
    add.navigationItem.title = @"发布新内容";
    [self pushViewController:add animated:YES];
    
    NSLog(@"select add 2");
}

-(void) loadContentTable
{
    [self loadThreeBtn];
    
    if(_contents == nil){
        _contents = [[UITableView alloc]initWithFrame:CGRectMake(5, _downBound+50, self.view.frame.size.width-10, self.view.frame.size.height-150 - _downBound) style:UITableViewStyleGrouped];
        _contents.dataSource = self;
        _contents.delegate = self;
        _contents.backgroundColor = [UIColor clearColor];
        [_contents setScrollEnabled:YES];
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去除分割线
    }
    
    [_fst.view addSubview:_contents];
}

-(void) loadThreeBtn
{
    float w = (self.view.frame.size.width - 20)/3;
    float h = 30;
    
    float x = self.view.frame.size.width/2 - 1.5*w;
    float y = _downBound + 10;
    
    if (_textBtn == nil) {
        _textBtn = [[UIButton alloc] init];
        _textBtn.frame = CGRectMake(x, y, w, h);
        
        [_textBtn setTitle:@"Text" forState:UIControlStateNormal];
        [_textBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _textBtn.layer.borderWidth = 1;
        _textBtn.layer.borderColor = [UIColor.grayColor CGColor];
        
        [_textBtn addTarget:self action:@selector(selectText) forControlEvents:UIControlEventTouchUpInside];
    }
    if (_albumBtn == nil) {
        _albumBtn = [[UIButton alloc] init];
        _albumBtn.frame = CGRectMake(x+w, y, w, h);
        
        [_albumBtn setTitle:@"Album" forState:UIControlStateNormal];
        [_albumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _albumBtn.layer.borderWidth = 1;
        _albumBtn.layer.borderColor = [UIColor.grayColor CGColor];
        
        [_albumBtn addTarget:self action:@selector(selectAlbum) forControlEvents:UIControlEventTouchUpInside];
    }
    if (_otherBtn == nil) {
        _otherBtn = [[UIButton alloc] init];
        _otherBtn.frame = CGRectMake(x+2*w, y, w, h);
        
        [_otherBtn setTitle:@"Others" forState:UIControlStateNormal];
        [_otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _otherBtn.layer.borderWidth = 1;
        _otherBtn.layer.borderColor = [UIColor.grayColor CGColor];
        
        [_otherBtn addTarget:self action:@selector(selectOther) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    [_fst.view addSubview:_albumBtn];
    [_fst.view addSubview:_otherBtn];
    [_fst.view addSubview:_textBtn];
}

-(void) selectAlbum
{
    NSLog(@"show the album");
    if (_state != 2) {
        _state = 2;
        // filter
        // [self getAlbumContent];
    }
    
    _albumBtn.backgroundColor = UIColor.grayColor;
    [_albumBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    _textBtn.backgroundColor = UIColor.whiteColor;
    _otherBtn.backgroundColor = UIColor.whiteColor;
    [_textBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.table reloadData];
}

-(void) selectText
{
    NSLog(@"show the text");
    if (_state != 1) {
        _state = 1;
        // filter
        // [self getTextContent];
    }
    
    _textBtn.backgroundColor = UIColor.grayColor;
    [_textBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    
    _albumBtn.backgroundColor = UIColor.whiteColor;
    _otherBtn.backgroundColor = UIColor.whiteColor;
    [_albumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.table reloadData];
}

-(void) selectOther
{
    [self getTextContent];
    [self getAlbumContent];
    
    [self.table reloadData];
}

#pragma mark - 重写---- table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.state == 1) {
        return self.textCells.count;
    } else if (self.state == 2) {
        return self.albumCells.count;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.state == 1) {
        // NSLog(@"it is text");
        return self.textCells[indexPath.row].cell_height;
    } else if (self.state == 2) {
        // NSLog(@"it is album");
        return self.albumCells[indexPath.row].cell_height;
    }
    
    return 155;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get contentRecord
    // PunchRecord pr = [DataController getRecordByIndex:self.showList[indexPath.row].integerValue];
    
    if (self.state == 1) {
        return self.textCells[indexPath.row];
    } else if (self.state == 2) {
        return self.albumCells[indexPath.row];
    }
    
    ContentCell *cell = [[ContentCell alloc] init];
    [cell test:0];
    return cell;
}

//设置选中效果
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (_state != 1 && _state != 2) return;
    
    CheckRecord *checkpage = [[CheckRecord alloc]init];
    [checkpage addChange];
    if (_state == 1)
        [checkpage loadWithContent:self.textContents.contents[indexPath.row] withUserInfo:self.userInfo withWide:self.view.frame.size.width];
    else if (_state == 2)
        [checkpage loadWithContent:self.albumContents.contents[indexPath.row] withUserInfo:self.userInfo withWide:self.view.frame.size.width];
    else
        return;
    
    //加入动画
    CATransition *animation = [CATransition animation];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"oglFlip";
    animation.duration = 0.5;
    animation.subtype = kCATransitionFromBottom;
    
    [self.view.layer addAnimation:animation forKey:nil];
    [self pushViewController:checkpage animated:NO];
}

#pragma mark - notification getUserInfoByID
- (void)getUserInfoByID:(NSString *)ID
{
    [_Request userInfoWithId:ID];
}

- (void)getInfoSuccess:(NSNotification *)notification
{
    NSLog(@"userGetInfo success");
    
    _userRes = [DataController userGetSelfInfo:[notification userInfo]];
    _userInfo = _userRes.info;
    
    [self reloadPage];
}
- (void)getInfoFailed:(NSNotification *)notification
{
    NSLog(@"userGetInfo fail");
}

#pragma mark - notification updateUserByName
- (void) changeName
{
    // 创建一个弹框
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"修改用户名" message:@"确定修改用户名吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建两个textFiled输入框
    [addAlertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新用户名";
    }];
    
    // 创建取消事件(按钮)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    // 添加 取消事件 到 弹窗界面
    [addAlertVC addAction:cancelAction];
    
    
    // 创建 确认按钮(事件) 并添加到弹窗界面
    UIAlertAction *confirmAction =[UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSString *name = addAlertVC.textFields.firstObject.text;
        self.tmpName = [[NSString alloc] initWithString:name];
        
        [self.Request userUpdateWithUsername:name];
        
        // NSLog(@"new name %@", name);
    }];
    //添加确定按钮(事件)到弹窗
    [addAlertVC addAction:confirmAction];
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
}

- (void)userUpdateSuccess:(NSNotification *)notification
{
    NSLog(@"userUpdate success");
    
    // [self.userName setTitle:self.tmpName forState:UIControlStateNormal];
    self.userInfo.name = [[NSString alloc] initWithString:self.tmpName];
    
    [self reloadPage];
}
- (void)userUpdateFailed:(NSNotification *)notification
{
    NSLog(@"userUpdate fail");
}

#pragma mark - notification contentGetText

- (void)getTextContent
{
    
    // [_Request contentGetTextById:@"5fbcf473f5beb22628d4b68d"];
    [_Request contentGetTextById:self.userRes.ID];
}

- (void)contentGetTextSuccess:(NSNotification *)notification
{
    NSLog(@"contentGetText success");
    
    [_textCells removeAllObjects];
    _textContents = [DataController contentGetTextById:[notification userInfo]];
    for (int i = 0 ; i < _textContents.contents.count; i ++) {
        ContentCell *cell = [[[ContentCell alloc] init] initWithContent:_textContents.contents[i] withUserInfo:self.userInfo withWide:self.view.frame.size.width];
        [_textCells addObject:cell];
    }
    
    _userContentNum.text = [[NSString alloc] initWithFormat:@"%ld", _textCells.count + _albumCells.count + _otherCells.count];
    
    NSLog(@"here?");
    [self.table reloadData];
}
- (void)contentGetTextFailed:(NSNotification *)notification
{
    NSLog(@"contentGetText fail");
}


#pragma mark - notification contentGetAlbum
- (void)getAlbumContent
{
    
    // [_Request contentGetAlbumById:@"5fbcf473f5beb22628d4b68d"];
    [_Request contentGetAlbumById:self.userRes.ID];
}

- (void)contentGetAlbumSuccess:(NSNotification *)notification
{
    NSLog(@"contentGetAlbum success");
    
    [_albumCells removeAllObjects];
    _albumContents = [DataController contentGetTextById:[notification userInfo]];
    for (int i = 0 ; i < _albumContents.contents.count; i ++) {
        ContentCell *cell = [[[ContentCell alloc] init] initWithContent:_albumContents.contents[i] withUserInfo:self.userInfo withWide:self.view.frame.size.width];
        [_albumCells addObject:cell];
    }
    
    // NSLog(@"album num = %ld", _albumCells.count);
    
    _userContentNum.text = [[NSString alloc] initWithFormat:@"%ld", _textCells.count + _albumCells.count + _otherCells.count];
    [self.table reloadData];
}
- (void)contentGetAlbumFailed:(NSNotification *)notification
{
    NSLog(@"contentGetAlbum fail");
}

@end
