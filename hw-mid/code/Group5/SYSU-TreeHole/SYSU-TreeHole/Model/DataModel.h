//
//  DataModel.h
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/16.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef DataModel_h
#define DataModel_h
#import <Foundation/Foundation.h>

@interface Info : NSObject
@property NSString *name;
@property NSString *avatar;
@property NSString *bio;
@property NSNumber *gender; // maybe enum

+(Info *) dic2Object:(NSDictionary *)dic;

@end

@interface User : NSObject
@property UInt64 uid;
@property UInt64 vid;
@property NSString *email;
@property UInt64 uclass; // maybe enum
@property Info *info;
@property NSString *token;
@property UInt64 maxSize;
@property UInt64 usedSize;
@property UInt64 singleSize;
@property NSArray<NSString *> *filesClass;
@property UInt64 likeCount;
@property UInt64 maxLikeCount;
@property NSDate *commentTime;
@property NSDate *contentTime;
// ... maybe not use

@end

@interface UserInfoRes : NSObject
@property NSString *ID;
@property NSString *State;
@property NSString *email;
@property NSString *name;
@property NSNumber *Class; // maybe enum
@property Info *info;
@property NSNumber *likeNum;
@property NSNumber *maxSize;
@property NSNumber *usedSize;
@property NSNumber *singleSize;
@property NSArray<NSString *> *filesClass;
@property NSNumber *contentCount;

+(UserInfoRes *) dic2Object:(NSDictionary *)dic;

@end

@interface NotificationDetail : NSObject
@property UInt64 nid;
@property NSData *time;
@property NSString *content;
@property NSString *sourceId;
@property NSString *targetId;
@property BOOL read;
@property NSString *type;
@end

@interface Notification : NSObject
@property UInt64 nid;
@property UInt64 userid;
@property NotificationDetail *notification;
@end


// Comment and Reply
@interface Reply : NSObject
@property NSString* ID;
@property NSString* contentId;
@property NSString* fatherId;
@property NSString* userId;
@property NSDate *date;
@property NSString *content;
@property NSInteger likeNum;

+(Reply *) dic2Object:(NSDictionary *)dic;

@end

@interface Comment : NSObject
@property NSString* ID;
@property NSString* contentId;
@property NSString* fatherId;
@property NSString* userId;
@property NSDate *date;
@property NSString *content;
@property NSInteger likeNum;

+(Comment *) dic2Object:(NSDictionary *)dic;

@end

@interface ReplyRes : NSObject

@property Info *father;
@property Info *user;
@property Reply *reply;

+(ReplyRes *) dic2Object:(NSDictionary *)dic;

@end

@interface CommentRes : NSObject

@property Comment *comment;
@property NSArray<ReplyRes *> *replies; //
@property Info *user;

+(CommentRes *) dic2Object:(NSDictionary *)dic;

@end

// file
@interface Album : NSObject

@property NSArray *Images;
@property NSString *Location;
@property NSString *Time;
@property NSString *Title;

+(Album *) dic2Object:(NSDictionary *)dic;

@end

@interface Content : NSObject
@property NSString *ID;
@property NSString *name;
@property NSString *detail;
@property NSString *ownId;
@property NSDate *publishDate;
@property NSDate *editDate;
@property NSInteger likeNum;
@property NSInteger commentNum;
@property BOOL Public;
@property BOOL Native;
@property NSString *type;
@property NSString *subType;
@property NSString *remark;
@property NSArray *tag;

@property Album *album;
@property NSArray *image;
@property NSString *append;
@property NSString *movie;
@property NSString *app;
@property NSArray *files;

+(Content *) dic2Object:(NSDictionary *)dic;
+(NSDictionary *) object2dic:(Content *)content;

@end

@interface ContentRes : NSObject

@property NSArray<Content *> *contents; // Content
@property NSArray<Info *> *user; // Info

+(ContentRes *) dic2Object:(NSDictionary *)dic;

@end

// maybe no use
@interface UserLike : NSObject
@property UInt64 likeId;
@property UInt64 userId;
@property NSArray *ids;
@end

@interface Tag : NSObject
@property UInt64 tid;
@property NSString *name;
@property UInt64 userId;
@property UInt64 count;
@end

/*
 * nz
 */
//The User's account to login
@interface UserLoginInfo :NSObject

@property(strong, nonatomic) NSString* name;

@property(strong, nonatomic) NSString* password;

+ (UserLoginInfo*) construct:(NSString*)names with:(NSString*) passwords;
@end

@interface NotificationRes : NSObject
@property NSString *state;
@property NSArray *notifications;
-(NotificationRes*)initwith:(NSString*)state andwith:(NSArray*)notification;
@end

// add for image
@interface File : NSObject

@property NSInteger count;
@property NSString *file;
@property NSInteger size;
@property NSDate *time;
@property NSString *title;
@property NSString *type;

+(File *) dic2Object:(NSDictionary *)dic;

@end

@interface Image : NSObject

@property File *file;
@property NSInteger native;
@property NSString *thumb;
@property NSString *url;

+(Image *) dic2Object:(NSDictionary *)dic;

@end

#endif /* DataModel_h */
