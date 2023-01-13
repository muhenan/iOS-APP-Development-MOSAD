//
//  RequestController.m
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/16.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestController.h"

@interface RequestController ()

@end

@implementation RequestController

static RequestController* _instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[RequestController alloc] init];
    });
    
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://172.18.178.56/api/"]];
        httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (void)makeRequest:(NSString *)url
             method:(NSString *)method
         parameters:(nullable NSDictionary *)parameters
   notificationName:(NSString *)notificationName {
    
    void (^successHandler)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // NSLog(@"%@: responseObject = %@", notificationName, [responseObject class]);
        // NSLog(@"%@: responseObject = %@", notificationName, responseObject);
        
        if ([notificationName isEqualToString:@"contentDelete"]) {
            // NSLog(@"class name = %@", [responseObject[@"Data"] class]);
            NSLog(@"%@: responseObject = %@", notificationName, [responseObject class]);
            NSLog(@"%@: responseObject = %@", notificationName, responseObject);
            
            // NSArray *arr = [[NSArray alloc] init];
            // NSArray *imgArr = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"background.jpg"], nil];
            // [_instance contentAddAlbumWithTitle:@"test" detail:@"album" tags:arr isPublic:YES images:imgArr];
            // [_instance TmpcontentPostTextWithTitle:@"test" detail:@"detail" tags:arr isPublic:YES];
        }
        if ([notificationName isEqualToString:@"contentUpdate"]) {
            // NSLog(@"class name = %@", [responseObject[@"Data"] class]);
            NSLog(@"%@: responseObject = %@", notificationName, [responseObject class]);
            NSLog(@"%@: responseObject = %@", notificationName, responseObject);
        }
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:[NSString stringWithFormat:@"%@%@", notificationName, @"Success"] object:self userInfo:responseObject]];
        
        
    };
    void (^failedHandler)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@: responseObject = %@", notificationName, error);
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:[NSString stringWithFormat:@"%@%@", notificationName, @"Failed"] object:self userInfo:@{}]];
    };
    
    if ([method isEqualToString:@"GET"]) {
        [httpManager GET:url
              parameters:parameters
                progress:nil
                 success:successHandler
                 failure:failedHandler];
    } else if ([method isEqualToString:@"POST"]) {
        [httpManager POST:url
               parameters:parameters
                 progress:nil
                  success:successHandler
                  failure:failedHandler];
    } else if ([method isEqualToString:@"PATCH"]) {
        [httpManager PATCH:url
                parameters:parameters
                   success:successHandler
                   failure:failedHandler];
    } else if ([method isEqualToString:@"DELETE"]) {
        [httpManager DELETE:url
                 parameters:parameters
                    success:successHandler
                    failure:failedHandler];
    } else if ([method isEqual:@"POST-multipart"]) {
        [httpManager POST:url
               parameters:nil
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    NSArray * keys = [parameters allKeys];
    for (NSString * key in keys) {
        NSDictionary * value = parameters[key];
        if ([@"file" isEqualToString:value[@"type"]]) {
            [formData appendPartWithFileData:value[@"data"]
                                        name:key
                                    fileName:key
                                    mimeType:value[@"mimeType"]
             ];
        } else {
            [formData appendPartWithFormData:value[@"data"]
                                        name:key];
        }
    }
}
                 progress:nil
                  success:successHandler
                  failure:failedHandler];
    } else if ([method isEqualToString:@"PATCH-multipart"]) {
        // TODO: NO PATCH & MULTIPART
    }
}

- (void)userLogout {
    [self makeRequest:@"user/logot"
               method:@"POST"
           parameters:nil
     notificationName:@"userLogout"];
}

- (void)userGetSelfInfo {
    [self makeRequest:@"user/info/self"
               method:@"GET"
           parameters:nil
     notificationName:@"userGetSelfInfo"];
}

- (void)userLoginWithUsername:(NSString *)username password:(NSString *)password {
    [self makeRequest:@"user/login/pass"
               method:@"POST"
           parameters:@{
                        @"name": username,
                        @"password": password,
                        }
     notificationName:@"userLogin"];
}

- (void)userRegisterWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email {
    [self makeRequest:@"user/register"
               method:@"POST"
           parameters:@{
                        @"name": username,
                        @"email": email,
                        @"password": password,
                        }
     notificationName:@"userRegister"];
}

- (void)userInfoWithId:(NSString *)_id {
    [self makeRequest:[NSString stringWithFormat:@"%@%@", @"user/info/", _id]
               method:@"GET"
           parameters:nil
     notificationName:@"userInfo"];
}

- (void)userUpdateWithUsername:(NSString *)username {
    [self makeRequest:@"user/name"
               method:@"POST"
           parameters:@{
                        @"name": username,
                        }
     notificationName:@"userUpdate"];
}

- (void)notificationReadOrUnreadById:(NSString *)_id isRead:(Boolean)isRead {
    [self makeRequest:[NSString stringWithFormat:@"%@%@", @"notification/read/", _id]
               method:@"PATCH"
           parameters:@{
                        @"isRead": isRead ? @YES : @NO
                        }
     notificationName:@"notificationReadOrUnread"];
}

- (void)notificationDeleteById:(NSString *)_id {
    [self makeRequest:[NSString stringWithFormat:@"%@%@", @"notification/", _id]
               method:@"DELETE"
           parameters:nil
     notificationName:@"notificationDelete"];
}

- (void)notificationGetUnread {
    [self makeRequest:@"notification/unread/"
               method:@"GET"
           parameters:nil
     notificationName:@"notificationGetUnread"];
}

- (void)notificationGetAll {
    [self makeRequest:@"notification/all/"
               method:@"GET"
           parameters:nil
     notificationName:@"notificationGetAll"];
}

#pragma mark ContentService

- (void)contentDeleteById:(NSString *)_id {
    [self makeRequest:[NSString stringWithFormat:@"%@%@", @"content/", _id]
               method:@"DELETE"
           parameters:nil
     notificationName:@"contentDelete"];
}

- (void)contentGetById:(NSString *)_id {
    [self makeRequest:[NSString stringWithFormat:@"%@%@", @"content/detail/", _id]
               method:@"GET"
           parameters:nil
     notificationName:@"contentGet"];
}

- (void)contentGetPublicListByPage:(NSNumber *)page eachPage:(NSNumber *)eachPage {
    [self makeRequest:@"content/public"
               method:@"GET"
           parameters:@{
                        @"page": page,
                        @"eachPage": eachPage,
                        }
     notificationName:@"contentGetPublicList"];
}

- (void)contentAddAlbumWithTitle:(NSString *)title
                          detail:(NSString *)detail
                            tags:(NSArray<NSString *> *)tags
                        isPublic:(BOOL)isPublic
                          images:(NSArray<UIImage *> *)images{
    NSString *url = [NSString stringWithFormat:@"content/album"];
    NSDictionary *dict;
    if (isPublic) {
        dict = @{@"title":title,@"detail":detail,@"tags":tags,@"isPublic":@YES};
    } else {
        dict = @{@"title":title,@"detail":detail,@"tags":tags,@"isPublic":@NO};
    }

    [httpManager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        int i=0;
        for (UIImage *image in images) {
            i=i+1;
            NSData *imageData = UIImagePNGRepresentation(image);
            // NSData *thumbData = UIImageJPEGRepresentation(image, 0.4);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file%d",i+1] fileName:[NSString stringWithFormat:@"file%d",i+1] mimeType:@"image/png"];
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"thumb%d",i+1] fileName:[NSString stringWithFormat:@"thumb%d",i+1] mimeType:@"image/png"];
            
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"add album = %@", responseObject);
        if([responseObject[@"State"] isEqualToString:@"success"]){
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"contentAddAlbumSuccess" object:self userInfo:responseObject]];
        }else{
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"contentAddAlbumFailed" object:self userInfo:@{}]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"contentAddAlbumFailed" object:self userInfo:@{}]];
    }];
}

- (void)contentGetAlbumById:(NSString *)_id {
    [self makeRequest:[NSString stringWithFormat:@"%@%@", @"content/album/", _id]
               method:@"GET"
           parameters:nil
     notificationName:@"contentGetAlbum"];
}

- (void)contentGetImageById:(NSString *)_id
                       path:(NSString *)path {
    [self makeRequest:[NSString stringWithFormat:@"%@%@/%@", @"file/album/", _id, path]
               method:@"GET"
           parameters:nil
     notificationName:@"contentGetImage"];
}

- (void)contentGetTextById:(NSString *)_id {
    [self makeRequest:[NSString stringWithFormat:@"%@%@", @"content/texts/", _id]
               method:@"GET"
           parameters:nil
     notificationName:@"contentGetText"];
}

- (void)contentPostTextWithTitle:(NSString *)title
                          detail:(NSString *)detail
                            tags:(NSArray<NSString *> *)tags
                        isPublic:(BOOL)isPublic
{
    
    NSLog(@"add text begin");
    
    NSString *url = [NSString stringWithFormat:@"content/text"];
    NSDictionary *dict;
    if (isPublic) {
        dict = @{@"title":title,@"detail":detail,@"tags":tags,@"isPublic":@YES};
    } else {
        dict = @{@"title":title,@"detail":detail,@"tags":tags,@"isPublic":@NO};
    }
    
    [self makeRequest:url method:@"POST" parameters:dict notificationName:@"contentAddText"];
}

- (void)contentUpdateById:(NSString *)_id
                    title:(NSString *)title
                   detail:(NSString *)detail
                     tags:(NSArray<NSString *> *)tags
                 isPublic:(BOOL)isPublic{
    NSDictionary *dict;
    if (isPublic) {
        dict = @{@"title":title,@"detail":detail,@"tags":tags,@"isPublic":@YES};
    } else {
        dict = @{@"title":title,@"detail":detail,@"tags":tags,@"isPublic":@NO};
    }
    
    [self makeRequest:[NSString stringWithFormat:@"%@%@", @"content/all/", _id]
               method:@"PATCH"
           parameters:dict
     notificationName:@"contentUpdate"];
}

# pragma mark CommentService

- (void)commentGetListById:(NSString *)_id {
    [self makeRequest:[NSString stringWithFormat:@"%@%@", @"comment/", _id]
               method:@"GET"
           parameters:nil
     notificationName:@"commentGetList"];
}

- (void)commentAddWithContentId:(NSString *)contentId
                       fatherId:(NSString *)fatherId
                        content:(NSString *)content
                        isReply:(BOOL)isReply{
    [self makeRequest:@"comment"
               method:@"POST"
           parameters:@{
                        @"contentId": contentId,
                        @"fatherId": fatherId,
                        @"content": content,
                        @"isReply": isReply ? @YES : @NO,
                        }
     notificationName:@"commentAdd"];
}

- (void)commentDeleteById:(NSString *)_id {
    [self makeRequest:[NSString stringWithFormat:@"%@%@", @"comment/", _id]
               method:@"DELETE"
           parameters:nil
     notificationName:@"commentDelete"];
}

// test

- (void)TmpcontentPostTextWithTitle:(NSString *)title
                          detail:(NSString *)detail
                            tags:(NSArray<NSString *> *)tags
                        isPublic:(BOOL)isPublic
{
    NSString *url = [NSString stringWithFormat:@"content/text"];
    NSDictionary *dict;
    if (isPublic) {
        dict = @{@"title":title,@"detail":detail,@"tags":tags,@"isPublic":@YES};
    } else {
        dict = @{@"title":title,@"detail":detail,@"tags":tags,@"isPublic":@NO};
    }
    
    [self makeRequest:url method:@"POST" parameters:dict notificationName:@"contentAddText"];
}


# pragma mark Like
- (void)likeAddToContent:(NSString *)ID
{
    NSDictionary *body = @{ @"isContent" : @YES, @"isComment" : @NO, @"isReply" : @NO };
    NSString *url = [NSString stringWithFormat:@"like/%@", ID];
    
    [self makeRequest:url method:@"POST" parameters:body notificationName:@"likeAdd"];
}

@end
