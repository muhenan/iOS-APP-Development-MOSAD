//
//  UserConfigViewController.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserConfigViewController.h"

@interface UserConfigViewController()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITextField* _setField1;
@property(nonatomic, strong) UITableView* _table;
@property(nonatomic)long _font;
@property(nonatomic)NSMutableArray* menuarray;
@end

@implementation UserConfigViewController

- (UserConfigViewController*) initWithSuper:(ChangedViewController* ) sups andvalue:(long) value{
    self.sup = sups;
    self._font = value;
    return self;
}
- (void) reloadData{
    [self._table removeFromSuperview];
    self._table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.center.x*2, self.view.center.y*2) style:UITableViewStyleGrouped];
    [self.view addSubview:self._table];
}
- (void) viewDidLoad{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self._table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.center.x*2, self.view.center.y*2) style:UITableViewStyleGrouped];
    [self._table setDelegate:self];
    [self._table setDataSource:self];
    [self.view addSubview:self._table];
    
    UIView *sliderView = [[UIView alloc]initWithFrame:CGRectMake(self.view.center.x+50, -40, 150, 120)];
        [self.view addSubview:sliderView];
        
        self._setField1 = [[UITextField alloc]initWithFrame:CGRectMake(60, 72, 60, 30)];
        self._setField1.backgroundColor = [UIColor clearColor];
        self._setField1.textColor = [UIColor blackColor];
        self._setField1.font = [UIFont systemFontOfSize:12];
        [sliderView addSubview:self._setField1];
        UISlider *fontSlider = [[UISlider alloc]initWithFrame:CGRectMake(5,77 , 140, 60)];
        fontSlider.minimumValue = 10;
        fontSlider.maximumValue = 30;
        fontSlider.value = self._font;
        long value = fontSlider.value;
        self._setField1.text = [NSString stringWithFormat:@"%ld",value];
        [fontSlider addTarget:self action:@selector(ChangeFont:) forControlEvents:UIControlEventValueChanged];
        [sliderView addSubview:fontSlider];
}

-(void)ChangeFont:(UISlider *)slider
{
    self._font = slider.value;
    self._setField1.text = [NSString stringWithFormat:@"%ld",self._font];
    
    [self._table reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text = @"test";
    cell.textLabel.font =[UIFont systemFontOfSize:self._font];
    self.sup._font = self._font;
    [self.sup reloadData];
    return cell;
}
@end
