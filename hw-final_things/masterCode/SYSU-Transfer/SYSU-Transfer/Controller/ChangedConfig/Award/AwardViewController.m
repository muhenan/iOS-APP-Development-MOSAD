//
//  AwardViewController.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AwardViewController.h"
#import "AwardCell.h"
@interface AwardViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UILabel* awardlabel;
@property (strong, nonatomic)UITableView* awards;
@property (strong, nonatomic)NSMutableArray* awarddata;
@property (strong, nonatomic)UIImage* defaultimage;

@end

@implementation AwardViewController

- (AwardViewController*) initWithSuper:(UIViewController* ) sups {
    
    self = [self init];
    self.sup = sups;
    return self;
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"award";
    
    
    self.awarddata = [[NSMutableArray alloc] init];
    UIImage* award1 = [UIImage imageNamed:@"award1.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage* award2 = [UIImage imageNamed:@"award2.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage* award3 = [UIImage imageNamed:@"award3.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage* award4 = [UIImage imageNamed:@"award4.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage* award5 = [UIImage imageNamed:@"award5.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage* award6 = [UIImage imageNamed:@"award6.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage* award7 = [UIImage imageNamed:@"award7.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage* award8 = [UIImage imageNamed:@"award8.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage* award9 = [UIImage imageNamed:@"award9.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    [self.awarddata addObjectsFromArray:@[award1, award2, award3, award4, award5, award6, award7, award8, award9]];
    self.awards = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.center.x*2, self.view.center.y*2) style:UITableViewStyleGrouped];
    self.awards.backgroundColor = [UIColor whiteColor];
    [self.awards setDelegate:self];
    [self.awards setDataSource:self];
    [self.awards registerClass:[awardcell class] forCellReuseIdentifier:@"award"];
    [self.view addSubview:self.awards];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    awardcell* cell = [tableView  dequeueReusableCellWithIdentifier:@"award" forIndexPath:indexPath];
    NSInteger count = self.awarddata.count;
    NSInteger from = row * 3;
    UIImage* image1 = nil;
    UIImage* image2 = nil;
    UIImage* image3 = nil;
    if(count >= from){
        image1 = self.awarddata[from];
    }
    from++;
    if(count >= from){
        image2 = self.awarddata[from];
    }
    from++;
    if(count >= from){
        image3 = self.awarddata[from];
    }
    [cell setController:self];
    [cell setProperty:image1 with:image2 with:image3 canClick:0 andlen:row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.center.y*2/3-10;
}
- (void) addImage: (UIImage*) image {
    
    [self.awarddata addObject:image];
    
}
@end


