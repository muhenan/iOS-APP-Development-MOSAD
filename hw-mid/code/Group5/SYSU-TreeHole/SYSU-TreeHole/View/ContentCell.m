//
//  ContentCell.m
//  SYSU-TreeHole
//
//  Created by itlab on 2020/12/3.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentCell.h"

@interface ContentCell()

@property (nonatomic, strong) UILabel *shell;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *likeNumLabel;
@property (nonatomic, strong) UILabel *commentNumLabel;

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) NSMutableArray<UIButton *> *imgBtns;

// location
@property CGFloat headSize;
@property CGFloat top;
@property CGFloat mid;
@property CGFloat end;
@property CGFloat wide;
@property CGFloat high;

// data
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@property NSInteger like;
@property NSInteger comment;
@property (nonatomic, strong) UIImage *head;

@end

@implementation ContentCell


- (instancetype)initWithContent:(Content *)content
                   withUserInfo:(Info *)info
                       withWide:(CGFloat)wide
{
    self.imgs = [[NSMutableArray alloc] init];
    self.imgBtns = [[NSMutableArray alloc] init];
    self.backgroundColor = UIColor.whiteColor;
    _content = content;
    _info = info;
    [self dataGenerate];
    
    // init
    _wide = wide;
    _headSize = _wide/10;
    _top = 10;
    
    // test
    // [self dataInit:1];
    
    // laod element
    [self loadHeadImg];
    [self loadName];
    [self loadTitle];
    [self loadDetail];
    [self loadImgs];
    [self loadLike];
    [self loadComment];
    
    _cell_height = _end-_top + _likeNumLabel.frame.size.height + 20;
    return self;
}

- (void) dataGenerate
{
    _name = _info.name;
    _title = _content.name;
    _head = [UIImage imageNamed:@"timg.jpeg"];
    _detail = _content.detail;
    _like = _content.likeNum;
    _comment = _content.commentNum;
    
    if ([_content.type isEqualToString:@"Album"])
    {
        NSArray* arr = _content.album.Images;
        
        for (int i = 0; i < arr.count; i ++) {
            Image *a = arr[i];
            NSURL *url = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"http://172.18.178.56/api/thumb/%@", a.thumb]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:data];
            
            [_imgs addObject:img];
        }
    } else {
        // [_imgs addObject:[UIImage imageNamed:@"timg.jpeg"]];
    }
}

- (void)test:(NSInteger)c
{
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imgs = [[NSMutableArray alloc] init];
    self.imgBtns = [[NSMutableArray alloc] init];
    self.backgroundColor = UIColor.whiteColor;
    
    // init
    _wide = self.frame.size.width;
    _headSize = _wide/10;
    _top = self.frame.size.height/3;
    
    // test
    [self dataInit:c];
    
    // laod element
    [self loadHeadImg];
    [self loadName];
    [self loadTitle];
    [self loadDetail];
    [self loadImgs];
    [self loadLike];
    [self loadComment];
    
    _cell_height = _end-_top + _likeNumLabel.frame.size.height + 20;
}

- (void)dataInit:(NSInteger)c
{
    for (int i = 0; i < c; i ++) {
        UIImage *img = [UIImage imageNamed:@"timg.jpeg"];
        [self.imgs addObject:img];
    }
}

- (void)loadHeadImg
{
    if (_headImg == nil) {
        UIImage *img = [UIImage imageNamed:@"timg.jpeg"];
        _headImg = [[UIImageView alloc] initWithImage:img];
        _headImg.frame = CGRectMake(10, _top, _headSize, _headSize);
        [self addSubview:_headImg];
    }
}

- (void)loadName
{
    if (_nameLabel == nil) {
        CGFloat size = _headSize * 0.5;
        CGFloat x = _headSize + 20;
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _top-2, _wide - _headSize - 30, size+5)];
        
        _nameLabel.text = _name;
        _nameLabel.font = [UIFont boldSystemFontOfSize:size];
        
        [self addSubview:_nameLabel];
    }
}

- (void)loadTitle
{
    if (_titleLabel == nil) {
        CGFloat size = _headSize * 0.4;
        CGFloat x = _headSize + 20;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _top+0.6*_headSize-2, _wide - _headSize - 30, size+5)];
        
        _titleLabel.text = _title;
        _titleLabel.font = [UIFont fontWithName:@"Arial" size:size];
        
        [self addSubview:_titleLabel];
    }
}

- (void)loadDetail
{
    if (_detailLabel == nil) {
        CGFloat x = 10;
        CGFloat y = _top + _headSize + 5;
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, _wide-20, 70)];
        _detailLabel.numberOfLines = 3;
        _detailLabel.font = [UIFont fontWithName:@"Arial" size:18];
        
        _detailLabel.text = _detail;
        [self addSubview:_detailLabel];
        
        _mid = y + _detailLabel.frame.size.height;
    }
}

- (void)loadImgs
{
    NSInteger n = _imgs.count;
    CGFloat size = _wide/4;
    CGFloat barrer = 10;
    
    if (n == 0) {
        _end = _mid;
    } else if (n == 1) {
        size = 3*size + 2*barrer;
        UIButton *img1 = [[UIButton alloc] initWithFrame:CGRectMake(barrer, _mid+barrer, size, size)];
        img1.tag = 200;
        
        [img1 setBackgroundImage:_imgs[0] forState:UIControlStateNormal];
        [self.imgBtns addObject:img1];
        
        _end = _mid + 2*barrer + size;
    } else if (n == 2) {
        size = (3*size + barrer)/2;
        
        for (int i = 0; i < n; i ++) {
            UIButton* img = [[UIButton alloc] initWithFrame:CGRectMake(barrer + i*(size+barrer), _mid+barrer, size, size)];
            img.tag = 200 + i;
            
            [img setBackgroundImage:_imgs[i] forState:UIControlStateNormal];
            [self.imgBtns addObject:img];
        }
        
        _end = _mid + 2*barrer + size;
    } else if (n == 3) {
        for (int i = 0; i < n; i ++) {
            UIButton* img = [[UIButton alloc] initWithFrame:CGRectMake(barrer + i*(size+barrer), _mid+barrer, size, size)];
            img.tag = 200 + i;
            
            [img setBackgroundImage:_imgs[i] forState:UIControlStateNormal];
            [self.imgBtns addObject:img];
        }
        
        _end = _mid + 2*barrer + size;
    } else if (n == 4) {
        size = (3*size + barrer)/2;
        
        for (int i = 0; i < n; i ++) {
            int x = i%2;
            int y = i/2;
            
            UIButton* img = [[UIButton alloc] initWithFrame:CGRectMake(barrer + x*(size+barrer), _mid + barrer + y * (size+barrer), size, size)];
            img.tag = 200 + i;
            
            [img setBackgroundImage:_imgs[i] forState:UIControlStateNormal];
            [self.imgBtns addObject:img];
        }
        
        _end = _mid + 3*barrer + 2*size;
    } else if (n >= 5 && n <= 9) {
        for (int i = 0; i < n; i ++) {
            int x = i%3;
            int y = i/3;
            
            UIButton* img = [[UIButton alloc] initWithFrame:CGRectMake(barrer + x*(size+barrer), _mid + barrer + y * (size+barrer), size, size)];
            img.tag = 200 + i;
            
            [img setBackgroundImage:_imgs[i] forState:UIControlStateNormal];
            [self.imgBtns addObject:img];
        }
        
        NSInteger a = (n-1)/3 + 1;
        _end = _mid + barrer + a * (size + barrer);
    } else if (n >= 9) {
        for (int i = 0; i < 9; i ++) {
            int x = i%3;
            int y = i/3;
            
            UIButton* img = [[UIButton alloc] initWithFrame:CGRectMake(barrer + x*(size+barrer), _mid + barrer + y * (size+barrer), size, size)];
            img.tag = 200 + i;
            
            [img setBackgroundImage:_imgs[i] forState:UIControlStateNormal];
            [self.imgBtns addObject:img];
        }
        
        NSInteger a = (n-1)/3 + 1;
        _end = _mid + barrer + a * (size + barrer);
    }
    
    for (int i = 0; i < _imgBtns.count; i ++) {
        [self addSubview:_imgBtns[i]];
        [_imgBtns[i] addTarget:self action:@selector(imgSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)imgSelect:(UIButton *)img
{
    // NSLog(@"img tag = %ld", img.tag);
}

- (void)loadLike
{
    if (_likeNumLabel == nil) {
        _likeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, _end+2, 100, 30)];
        _likeNumLabel.text = [[NSString alloc] initWithFormat:@"%ld", _like];
        _likeNumLabel.font = [UIFont fontWithName:@"Arial" size:18];
        _likeNumLabel.textColor = UIColor.grayColor;
        [_likeNumLabel sizeToFit];
        
        UIButton* like = [[UIButton alloc] initWithFrame:CGRectMake(-30, -2, 25, 25)];
        [like setBackgroundImage:[UIImage imageNamed:@"good_g.png"] forState:UIControlStateNormal];
        [_likeNumLabel addSubview:like];
        
        [self addSubview:_likeNumLabel];
    }
}

- (void)loadComment
{
    if (_commentNumLabel == nil) {
        _commentNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(40+_wide/4, _end+2, 100, 25)];
        _commentNumLabel.text = [[NSString alloc] initWithFormat:@"%ld", _comment];
        _commentNumLabel.font = [UIFont fontWithName:@"Arial" size:18];
        _commentNumLabel.textColor = UIColor.grayColor;
        [_commentNumLabel sizeToFit];
        
        UIButton* comment = [[UIButton alloc] initWithFrame:CGRectMake(-30, -2, 25, 25)];
        [comment setBackgroundImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
        [_commentNumLabel addSubview:comment];
        
        [self addSubview:_commentNumLabel];
    }
}

@end
