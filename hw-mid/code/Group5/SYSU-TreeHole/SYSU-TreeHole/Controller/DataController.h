//
//  DataController.h
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/16.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef DataController_h
#define DataController_h
#import "DataModel.h"

@interface DataController : NSObject

+ (UserInfoRes *)getSelfInfo;

+ (void) etSelfInfo:(UserInfoRes *)userInfo;

+ (ContentRes *)contentGetPublicListByPage:(NSDictionary *)respond;

+ (Content *)contentGetById:(NSDictionary *)respond;

+ (ContentRes *)contentGetTextById:(NSDictionary *)respond;

+ (UserInfoRes *)userInfoWithId:(NSDictionary *)respond;

+ (UserInfoRes *)userGetSelfInfo:(NSDictionary *)respond;

+ (NSMutableArray<ContentRes *> *)commentGetListById:(NSDictionary *)respond;

@end

#endif /* DataController_h */
