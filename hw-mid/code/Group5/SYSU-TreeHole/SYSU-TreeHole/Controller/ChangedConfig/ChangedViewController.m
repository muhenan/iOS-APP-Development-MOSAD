//
//  ChangedViewController.m
//
//  Created by nz on 2020/10/28.
//

#import "DataModel.h"
#import "ChangedViewController.h"
#import "ConfigCell.h"
#import "AwardViewController.h"
#import "StoreViewController.h"
#import "UserDetailViewController.h"
#import "NotificationViewController.h"
#import "UserConfigViewController.h"
#import <AFNetworking.h>
@interface ChangedViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UIViewController* fst;

@property(strong, nonatomic) UIViewController* sup;
@property(strong, nonatomic) UserLoginInfo* user;

@property(strong, nonatomic) UIImageView* uiView;
@property(strong, nonatomic) UILabel* uitf;

@property(strong, nonatomic) UIView* circleView;

@property(strong, nonatomic) UILabel* uilabel;
@property(strong, nonatomic) UILabel* username;
@property(strong, nonatomic) UILabel* state;

@property(nonatomic)NSMutableArray* menuarray;
@property(nonatomic)NSIndexPath *selectedIndexPath;

@property(strong, nonatomic) LoginBackground* bgView;

@property(strong, nonatomic) UILabel* about;
@property(strong, nonatomic) UILabel* aboutdetail;

@property(strong, nonatomic) UIButton *button;
@property(strong, nonatomic) UIButton *detail;
@property(nonatomic) NSString* used;
@property(nonatomic) NSString* max;
@property(nonatomic) NSString* email;
@property(nonatomic) NSString* unread;
@end

@implementation ChangedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.user = nil;
    
    _fst = [[UIViewController alloc] init];
    _fst.view.backgroundColor = UIColor.whiteColor;
    _fst.navigationItem.title = @"设置";
    [self pushViewController:_fst animated:YES];
    
    [self.tabBarController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
        _fst.view.backgroundColor = [UIColor whiteColor];
        if(self.uiView == nil) {
            NSString* image = @"a.png";
            UIImage* uiImage = [UIImage imageNamed:image inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
            self.uiView = [[UIImageView alloc] initWithImage:uiImage];
            self.uiView.frame = CGRectMake(self.view.center.x / 2-80, 120, 80, 80);
            self.uiView.layer.cornerRadius = 40;
            self.uiView.layer.masksToBounds = YES;
            [_fst.view addSubview:self.uiView];
        }
//
//
            //username
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSString* url = @"http://172.18.178.56/api/user/info/self";
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {// 请求进度
}
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"请求成功：%@",responseObject);
                self.used =  [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"UsedSize"]];
                self.max =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"MaxSize"]];
                self.email =[responseObject objectForKey:@"Email"];
                NSString* name = [responseObject objectForKey:@"Name"];
                self.name = name;
                
                     }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
                NSLog(@"请求失败：%@",error);

                     }];
            url = @"http://172.18.178.56/api/notification/unread";
            [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"success %@",responseObject);
                self.unread = [responseObject objectForKey:@"Data"];
                self.username = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-80, 125, 300, 40)];
                self.username.font = [UIFont systemFontOfSize:25];
                self.username.text = self.name;
                [self.username setTextAlignment:NSTextAlignmentLeft];
                [self.fst.view addSubview:self.username];
                //state
                self.state = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-80, 165, 300, 40)];
                self.state.text = @"Happy";
                [self.state setTextAlignment:NSTextAlignmentLeft];
                [self.state setTextColor:[UIColor grayColor]];
                [self.fst.view addSubview:self.state];
                UIImage* notification_photo = [UIImage imageNamed:@"notification.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
                configcell* notification = [configcell initWith:@"notification" andwith:notification_photo];
                UIImage* award_photo = [UIImage imageNamed:@"award.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
                configcell* award = [configcell initWith:@"award" andwith:award_photo];
                UIImage* store_photo = [UIImage imageNamed:@"store.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
                configcell* store = [configcell initWith:@"store" andwith:store_photo];
                UIImage* config_photo =[UIImage imageNamed:@"configicon.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
                configcell* config = [configcell initWith:@"config" andwith:config_photo];
                UIImage* logout_photo =[UIImage imageNamed:@"logout.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
                configcell* logout = [configcell initWith:@"logout" andwith:logout_photo];
                
                self.menuarray = [[NSMutableArray alloc] init];
                [self.menuarray addObjectsFromArray:@[notification, award , store, config, logout]];
                
                //main
                self.main = [[UITableView alloc] initWithFrame:CGRectMake(0, 230, self.view.center.x*2, self.view.center.y*2-230) style:UITableViewStyleGrouped];
                [self.main setDelegate:self];
                [self.main setDataSource:self];
                [self.fst.view addSubview:self.main];

                
                //detail_image
                NSString* image2 = @"detail.png";
                UIImage* detailImage = [UIImage imageNamed:image2 inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];

                //detail
                self.detail = [UIButton buttonWithType:UIButtonTypeSystem];
                [self.detail setFrame:CGRectMake(330, 155, 20, 20)];
                [self.detail setBackgroundImage:detailImage forState:UIControlStateNormal];
                [self.detail addTarget:self action:@selector(Clicked) forControlEvents:UIControlEventTouchUpInside];
                [self.fst.view addSubview:self.detail];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        
    
    
}
-(void)resetname{
    [self.username removeFromSuperview];
    self.username = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-80, 125, 300, 40)];
    self.username.text = self.name;
    self.username.font = [UIFont systemFontOfSize:25];
    [self.username setTextAlignment:NSTextAlignmentLeft];
    [self.fst.view addSubview:self.username];
}
- (void) reloadData{
    [self.main removeFromSuperview];
    self.main = [[UITableView alloc] initWithFrame:CGRectMake(0, 230, self.view.center.x*2, self.view.center.y*2-230) style:UITableViewStyleGrouped];
    [self.main setDelegate:self];
    [self.main setDataSource:self];
    [self.fst.view addSubview:self.main];
}
- (ChangedViewController*) initWithSuper:(UIViewController* ) sups {
    self = [self init];
    self.sup = sups;
    return self;
}
- (void)Clicked{
    UserDetailViewController* detailController = [[UserDetailViewController alloc] initWithUserName:self.username.text andsup:self andemail:self.email andused:self.used andmax:self.max];
    [self pushViewController:detailController animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuarray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    configcell* config = self.menuarray[indexPath.row];
    cell.textLabel.text = config.title;
    cell.imageView.image = config.photo;
    if([config.title isEqualToString:@"notification"]){
        if([self.unread isEqualToString:@"0"]){
        }
        else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@"新通知"];
        [cell.detailTextLabel setTextColor:[UIColor whiteColor]];
        cell.detailTextLabel.backgroundColor = [UIColor redColor];
        cell.detailTextLabel.layer.cornerRadius = 0.5;
        }
    }
    cell.textLabel.font =[UIFont systemFontOfSize:self._font];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath=indexPath;
    configcell *contact=self.menuarray[indexPath.row];
    NSString* text = contact.title;
    if([text isEqualToString:@"notification"]){
        NotificationViewController* noti = [[NotificationViewController alloc] initWithUserName:self.name andsup:self];
        [self pushViewController:noti animated:YES];
    }
    else if([text isEqualToString:@"award"]){
        AwardViewController* awardcontroller = [AwardViewController alloc];
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromTop;
        [self.view.layer addAnimation:transition forKey:nil];
        [self pushViewController:awardcontroller animated:YES];
    }
    else if([text isEqualToString:@"store"]){
        StoreViewController* storecontroller = [[StoreViewController alloc] initWithSuper:self andused:self.used andmax:self.max];
        [self pushViewController:storecontroller animated:YES];
    }
    else if([text isEqualToString:@"config"]){
        UserConfigViewController* config = [[UserConfigViewController alloc] initWithSuper:self andvalue:self._font];
        [self pushViewController:config animated:YES];
    }
    else if([text isEqualToString:@"logout"]){
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"quit or not" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSString* url = @"http://172.18.178.56/api/user/logout";
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"success %@", responseObject);
                UITabBarController* utbc = [[UITabBarController alloc] init];
                //set tabbar
                UIImage* ConfigImage = [UIImage imageNamed:@"Config.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
                UIImage* ConfigSelectedImage = [UIImage imageNamed:@"ConfigSelected.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
                LoginController* uic = [[LoginController alloc] init];
                uic.tabBarItem.title = @"我的";
                [uic.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
                uic.tabBarItem.image = ConfigImage;
                [uic.tabBarItem setImage:[ConfigImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [uic.tabBarItem setSelectedImage:[ConfigSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                utbc.viewControllers = @[uic];
                [self setViewControllers:@[utbc]];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
            }];
        [alertVc addAction:cancle];
        [alertVc addAction:confirm];
        [self presentViewController:alertVc animated:YES completion:^{
                nil;
            }];
    }
}





@end
