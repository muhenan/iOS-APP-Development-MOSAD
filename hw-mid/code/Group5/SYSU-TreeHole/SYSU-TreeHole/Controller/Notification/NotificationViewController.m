//
//  NotificationViewController.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationViewController.h"
#import "NotificationCell.h"
#import "DataModel.h"
#import <AFNetworking.h>
@interface NotificationViewController()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic)NSIndexPath *selectedIndexPath;

@end

@implementation NotificationViewController

- (NotificationViewController*) initWithUserName:(NSString* ) username andsup:(ChangedViewController*) sup{
    self.name = username;
    self.sup = sup;
    return self;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString* url = @"http://172.18.178.56/api/notification/all";
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success %@",responseObject);
//        NSMutableDictionary* data =[[NSMutableDictionary alloc] initWithDictionary:[[responseObject objectForKey:@"Notification"] objectForKey:@"Data"]];
//        NSMutableDictionary* user =[[NSMutableDictionary alloc] initWithDictionary:[[responseObject objectForKey:@"Notification"] objectForKey:@"User"]];
//        NSMutableDictionary* all = [[NSMutableDictionary alloc] initWithDictionary:data];
//        [all addEntriesFromDictionary:user];
        self.menuarray = [[NSMutableArray alloc] initWithArray: [responseObject objectForKey:@"Notification"] ];
        self.detail = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.center.x*2, self.view.center.y*2) style:UITableViewStyleGrouped];
        [self.detail setDelegate:self];
        [self.detail setDataSource:self];
        [self.detail registerClass:[NotificationCell class] forCellReuseIdentifier:@"notification"];
        [self.view addSubview:self.detail];
        [self.detail reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void) reloadData{
    [self.detail removeFromSuperview];
    self.detail = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.center.x*2, self.view.center.y*2) style:UITableViewStyleGrouped];
    [self.detail setDelegate:self];
    [self.detail setDataSource:self];
    [self.detail registerClass:[NotificationCell class] forCellReuseIdentifier:@"notification"];
    [self.view addSubview:self.detail];
}
- (void )getArray{
    
//    NotificationDetail* detail1 = [NotificationDetail alloc];
//    Notification* noti1 = [Notification alloc];
//    detail1.content = @"qaq";
//    detail1.read = NO;
//    NSString *string = @"just now";
//    NSData *data1 = [string dataUsingEncoding:NSUTF8StringEncoding];
//    noti1.notification = detail1;
//
//    NotificationDetail* detail2 = [NotificationDetail alloc];
//    Notification* noti2 = [Notification alloc];
//    detail2.content = @"wakaka";
//    detail2.read = YES;
//    NSString *string1 = @"1 minute ago";
//    NSData *data2 = [string1 dataUsingEncoding:NSUTF8StringEncoding];
//    noti2.notification = detail2;
//
//    NSArray* arr = [[NSArray alloc] initWithObjects:noti1, noti2, nil];
//    NotificationRes* res = [[NotificationRes alloc] initwith:@"happy" andwith:arr];
//    return res;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuarray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationCell* cells = [[NotificationCell alloc] init];
    bool bo = [[[self.menuarray[indexPath.row] objectForKey:@"Data"] objectForKey:@"Read"] boolValue];
    long num =[[[self.menuarray[indexPath.row] objectForKey:@"Data"] objectForKey:@"CreateTime"] longValue];
    [cells setProperty: [[self.menuarray[indexPath.row] objectForKey:@"User"] objectForKey:@"Name"] andsource:[[self.menuarray[indexPath.row] objectForKey:@"Data"] objectForKey:@"SourceID"] andread:bo andtype:[[self.menuarray[indexPath.row] objectForKey:@"Data"] objectForKey:@"Type"] andtime:num  andcontent: [[self.menuarray[indexPath.row] objectForKey:@"Data"] objectForKey:@"Content"]];
    return cells;
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
//
//    cell.textLabel.text = config.notification.content;
//    if(config.notification.read == NO){
//        [cell.textLabel setTextColor:[UIColor blackColor]];
//        UIImage* notice_photo = [UIImage imageNamed:@"notice.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
//        cell.imageView.image = notice_photo;
//    }
//    else {
//        [cell.textLabel setTextColor:[UIColor grayColor]];
//        cell.imageView.image = nil;
//    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath=indexPath;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString* url =[NSString stringWithFormat:@"%@%@", @"http://172.18.178.56/api/notification/read/", [[self.menuarray[indexPath.row] objectForKey:@"Data"] objectForKey:@"ID"] ] ;
    NSDictionary* data = @{@"isRead":@YES};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager PATCH:url parameters:data success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self viewDidLoad];
        [self.sup viewDidLoad];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
//    [[self.menuarray[indexPath.row] objectForKey:@"Data"] setObject: [NSNumber numberWithBool:YES] forKey:@"Read"];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString* url = @"http://172.18.178.56/api/notification/";
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager DELETE:[NSString stringWithFormat:@"%@%@", url, [[self.menuarray[indexPath.row] objectForKey:@"Data"] objectForKey:@"ID"] ] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self.menuarray removeObjectAtIndex:indexPath.row];
            [self.detail deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade ];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
@end
