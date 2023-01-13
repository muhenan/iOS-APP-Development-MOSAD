//
//  DataController.m
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/16.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataController.h"

@implementation DataController

static UserInfoRes *selfInfo;

+(UserInfoRes *) getSelfInfo
{
    return selfInfo;
}

+(void) setSelfInfo:(UserInfoRes *)userInfo
{
    selfInfo = userInfo;
}

+(ContentRes *) contentGetPublicListByPage:(NSDictionary *)respond
{
    NSDictionary *td = respond;
    ContentRes *res = [[ContentRes alloc] init];
    NSMutableArray<Info *> *users = [[NSMutableArray alloc] init];
    NSMutableArray<Content *> *contents = [[NSMutableArray alloc] init];
    NSArray *arr = [[NSArray alloc] initWithArray:(NSArray *)td[@"Data"]];
    NSInteger count = [arr count];
    
    // NSLog(@"arr[0].user = %@", arr[0][@"User"]);
    // NSLog(@"arr[0].data = %@", arr[0][@"Data"]);
    
    for (int i = 0; i < count; i ++){
        [users addObject:[Info dic2Object:arr[i][@"User"]]];
        [contents addObject:[Content dic2Object:arr[i][@"Data"]]];
    }
    
    res.contents = [[NSArray alloc] initWithArray:contents];
    res.user = [[NSArray alloc] initWithArray:users];
    // NSLog(@"Count = %@", res.contents[0].name);
    
    return res;
}

+(ContentRes *) contentGetById:(NSDictionary *)respond
{
    NSDictionary *td = respond;
    
    NSString *state = td[@"State"];
    if ([state isEqualToString:@"success"]) {
        // NSLog(@"Get Content By ID Success");
        
        ContentRes *res = [[ContentRes alloc] init];
        res.contents = [NSArray arrayWithObjects:[Content dic2Object:td[@"Data"]], nil];
        res.user = [NSArray arrayWithObjects:[Info dic2Object:td[@"User"]], nil];
        
        return res;
    } else {
        NSLog(@"Get Content By ID Fail!");
        return nil;
    }
}

+ (ContentRes *)contentGetTextById:(NSDictionary *)respond
{
    NSDictionary *td = respond;
    ContentRes *res = [[ContentRes alloc] init];
    NSMutableArray<Content *> *contents = [[NSMutableArray alloc] init];
    NSArray *arr = [[NSArray alloc] initWithArray:(NSArray *)td[@"Data"]];
    NSInteger count = [arr count];
    
    for (int i = 0; i < count; i ++){
        [contents addObject:[Content dic2Object:arr[i]]];
    }
    
    res.contents = [[NSArray alloc] initWithArray:contents];
    
    return res;
}

+(UserInfoRes *) userInfoWithId:(NSDictionary *)respond
{
    return [UserInfoRes dic2Object:respond];
}

+(UserInfoRes *) userGetSelfInfo:(NSDictionary *)respond
{
    selfInfo = [UserInfoRes dic2Object:respond];
    return selfInfo;
}

// comment
+(NSMutableArray<CommentRes *> *) commentGetListById:(NSDictionary *)respond
{
    NSMutableArray<CommentRes *> *res = [[NSMutableArray alloc] init];
    
    if (! [respond[@"State"] isEqualToString:@"success"]) {
        NSLog(@"commentGetListById request fail");
    } else if ([respond[@"Data"] isKindOfClass:[NSNull class]]) {
        NSLog(@"commentGetListById get Nothing");
    } else {
        NSLog(@"YES");
        
        NSArray *arr = respond[@"Data"];
        NSLog(@"arr[0] = %@", arr[0]);
        for (int i = 0; i < arr.count; i ++) {
            CommentRes *tmp = [CommentRes dic2Object:(NSDictionary *)arr[i]];
            [res addObject:tmp];
        }
    }
    
    return res;
}

@end
