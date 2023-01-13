//
//  RequestController.h
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/16.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef RequestController_h
#define RequestController_h

#import "DataModel.h"
#import "DataController.h"
#import <AFNetworking/AFNetworking.h>

@interface RequestController : NSObject

{
    AFHTTPSessionManager* httpManager;
}

+(instancetype) shareInstance;

- (instancetype)init;

- (void)makeRequest:(NSString *)url
             method:(NSString *)method
         parameters:(nullable NSDictionary *)parameters
   notificationName:(NSString *)notificationName;

#pragma mark UserInfoService
- (void)userLogout;
- (void)userGetSelfInfo;
- (void)userLoginWithUsername:(NSString *)username password:(NSString *)password;
- (void)userRegisterWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email;
- (void)userInfoWithId:(NSString *)_id;
- (void)userUpdateWithUsername:(NSString *)username;

#pragma mark NotificationService
- (void)notificationReadOrUnreadById:(NSString *)_id isRead:(Boolean)isRead;
- (void)notificationDeleteById:(NSString *)_id;
- (void)notificationGetUnread;
- (void)notificationGetAll;


#pragma mark ContentService
- (void)contentDeleteById:(NSString *)_id;
- (void)contentGetById:(NSString *)_id;
- (void)contentGetPublicListByPage:(NSNumber *)page eachPage:(NSNumber *)eachPage;
- (void)contentGetAlbumById:(NSString *)_id;
- (void)contentGetImageById:(NSString *)_id
                       path:(NSString *)path;
- (void)contentGetTextById:(NSString *)_id;
- (void)contentAddAlbumWithTitle:(NSString *)title
                          detail:(NSString *)detail
                            tags:(NSArray<NSString *> *)tags
                        isPublic:(BOOL)isPublic
                          images:(NSArray<UIImage *> *)images;
- (void)contentPostTextWithTitle:(NSString *)title
                          detail:(NSString *)detail
                            tags:(NSArray<NSString *> *)tags
                        isPublic:(BOOL)isPublic;
- (void)contentUpdateById:(NSString *)_id
                    title:(NSString *)title
                   detail:(NSString *)detail
                     tags:(NSArray<NSString *> *)tags
                 isPublic:(BOOL)isPublic;


# pragma mark CommentService
- (void)commentGetListById:(NSString *)_id;
- (void)commentAddWithContentId:(NSString *)contentId
                       fatherId:(NSString *)fatherId
                        content:(NSString *)content
                        isReply:(BOOL)isReply;
- (void)commentDeleteById:(NSString *)_id;

# pragma mark Like
- (void)likeAddToContent:(NSString *)ID;

@end

#endif /* RequestController_h */
