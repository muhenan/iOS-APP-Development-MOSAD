//
//  AppDelegate.m
//  SYSU-Transfer
//
//  Created by itlab on 2020/12/21.
//  Copyright © 2020 itlab. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "RootTabBarController.h"
#import "FileManager.h"

@interface AppDelegate ()

@end

AFHTTPSessionManager *httpManager;
AFHTTPSessionManager *loadManager;

@implementation AppDelegate

- (void)initNetwork
{
    extern AFHTTPSessionManager *httpManager;
    httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://222.200.161.218:8080"]];
    httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
    httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    extern AFHTTPSessionManager *loadManager;
    loadManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://222.200.161.218:8080"]];
    loadManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    loadManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    loadManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
}

- (void)testNetwork
{
    // log in
    NSLog(@"log in");
    extern AFHTTPSessionManager *httpManager;
    [httpManager POST:@"/user/sign_in"
            parameters:@{
                         @"username": @"test",
                         @"password": @"test",
                         }
               headers:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                   NSLog(@"response object = %@", responseObject);
                   
                   // get root
                   [httpManager POST:@"/folders/"
                           parameters:@{
                                        }
                              headers:nil
                             progress:nil
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                                  NSLog(@"get root");
                                  NSLog(@"response object = %@", responseObject);
                              }
                              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                                  NSLog(@"get root fail");
                              }];
                   
                   [httpManager POST:@"/folders/404/"
                               parameters:@{
                                            }
                                  headers:nil
                                 progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                                      NSLog(@"get child floder 404");
                                      NSLog(@"response object = %@", responseObject);
                                      
                                      
                                      
                                  }
                                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                                      NSLog(@"get 404 fail");
                                  }];
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                   NSLog(@"log in fail");
               }];
    
}

- (void)testLocal
{
    NSString *str = @"qin";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [FileManager CreateDirByPath:@"qin/qin"];
    [FileManager WriteFile:data ByName:@"qin.txt"];
    
    NSString *path = @"qin/";
    NSArray *arr = [FileManager ReadDirByPath:path];
    NSLog(@"dir(%@) = %@", path, arr);
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initNetwork];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    
    // 使用ViewController作为登录页面
    ViewController *VC = [[ViewController alloc] init];
    // RootTabBarContorller *RTC = [[RootTabBarContorller alloc] init];
    
    self.window.rootViewController=VC;
    self.window.backgroundColor=[UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
