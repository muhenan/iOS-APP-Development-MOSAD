//
//  UserDetailViewController.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDetailViewController.h"
//#import "DataModel.h"
#import "UserInfoCell.h"
//#import "UserEditViewController.h"
@interface UserDetailViewController()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic)NSIndexPath *selectedIndexPath;
@end

@implementation UserDetailViewController

- (UserDetailViewController*) initWithUserName:(NSString* ) username andsup:(UIViewController*) sup andemail:(NSString *)email andused:(NSString *)used andmax:(NSString *)max{
    self.name = username;
    self.email = email;
    self.max = max;
    self.used = used;
    self.sup = sup;
    return self;
}
- (void)viewDidLoad {
    [self setMenuArray];

    self.detail = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.center.x*2, self.view.center.y*2) style:UITableViewStyleGrouped];
    [self.detail setDelegate:self];
    [self.detail setDataSource:self];
    [self.view addSubview:self.detail];
    self.sup.name = self.name;
    [self.sup resetname];
    
}

- (void)setMenuArray{
    UserInfoCell* name = [[UserInfoCell alloc] initWith:@"name" andwith:self.name];
    UserInfoCell* email = [[UserInfoCell alloc] initWith:@"email" andwith:self.email];
    UserInfoCell* usedSize = [[UserInfoCell alloc] initWith:@"usedSize" andwith:self.used];
    UserInfoCell* maxSize =[[UserInfoCell alloc] initWith:@"maxSize" andwith:self.max];
    UserInfoCell* moreDetail =[[UserInfoCell alloc] initWith:@"More Detail" andwith:@""];
    self.menuarray = [[NSMutableArray alloc] init];
    [self.menuarray addObjectsFromArray:@[name, email, usedSize, maxSize, moreDetail]];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuarray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UserInfoCell* cells = self.menuarray[indexPath.row];
    cell.textLabel.text = cells.title;
    cell.detailTextLabel.text = cells.info;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.selectedIndexPath=indexPath;
//    UserInfoCell *contact=self.menuarray[indexPath.row];
//    NSString* text = contact.title;
//    if([text isEqualToString:@"name"]){
//        UserEditViewController* edit = [[UserEditViewController alloc] initWithSup:self];
//        [self.navigationController pushViewController:edit animated:YES];
//    }
}

@end
