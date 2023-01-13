//
//  DataModel.m
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/13.
//  Copyright © 2020 itlab. All rights reserved.
//

#import "DataModel.h"

@implementation Info

+(Info *) dic2Object:(NSDictionary *)dic
{
    Info* res = [[Info alloc] init];
    
    res.avatar = dic[@"Avatar"];
    res.bio = dic[@"Bio"];
    res.gender = dic[@"Gender"];
    res.name = dic[@"Name"];
    
    return res;
}

@end

@implementation Content

+(Content *) dic2Object:(NSDictionary *)dic
{
    Content *res = [[Content alloc] init];
    NSNumber *tmp = [[NSNumber alloc] init];
    
    res.files = nil;
    tmp = dic[@"PublishDate"];
    res.publishDate = [NSDate dateWithTimeIntervalSince1970:[tmp integerValue]/1000];
    tmp = dic[@"LikeNum"];
    res.likeNum = [tmp integerValue];
    res.name = dic[@"Name"];
    res.ID = dic[@"ID"];
    tmp = dic[@"EditDate"];
    res.editDate = [NSDate dateWithTimeIntervalSince1970:[tmp integerValue]/1000];
    res.subType = dic[@"SubType"];
    res.tag = nil;
    res.movie = nil;
    res.app = nil;
    tmp = dic[@"CommentNum"];
    res.commentNum = [tmp integerValue];
    tmp = dic[@"Public"];
    res.Public = [tmp boolValue];
    res.type = dic[@"Type"];
    res.detail = dic[@"Detail"];
    res.ownId = dic[@"OwnID"];
    res.image = nil;
    tmp = dic[@"Native"];
    res.Native = [tmp boolValue];
    res.remark = nil;
    res.album = [Album dic2Object:dic[@"Album"]];
    
    return res;
}

+(NSDictionary *) object2dic:(Content *)content
{
    NSDictionary *res = [[NSDictionary alloc] init];
    
    return res;
}

@end

@implementation Album

+(Album *) dic2Object:(NSDictionary *)dic
{
    Album *res = [[Album alloc] init];
    
    NSArray *tmp;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    tmp = dic[@"Images"];
    for (int i = 0; i < tmp.count; i ++) {
        [arr addObject:[Image dic2Object:tmp[i]]];
    }
    res.Images = [[NSArray alloc] initWithArray:arr];
    
    res.Location = dic[@"Location"];
    res.Time = dic[@"Time"];
    res.Title = dic[@"Title"];
    
    return res;
}

@end

@implementation ContentRes

+(ContentRes *) dic2Object:(NSDictionary *)dic
{
    ContentRes *res;
    
    return res;
}

@end

@implementation Reply

+(Reply *) dic2Object:(NSDictionary *)dic
{
    Reply *res = [[Reply alloc] init];
    NSNumber *tmp = [[NSNumber alloc] init];
    
    res.contentId = dic[@"ContentID"];
    res.content = dic[@"Content"];
    tmp = dic[@"Date"];
    res.date = [NSDate dateWithTimeIntervalSince1970:[tmp integerValue]/1000];
    res.fatherId = dic[@"FatherID"];
    res.ID = dic[@"ID"];
    tmp = dic[@"LikeNum"];
    res.likeNum = [tmp integerValue];
    res.userId = dic[@"UserID"];
    
    return res;
}

@end

@implementation Comment

+(Comment *) dic2Object:(NSDictionary *)dic
{
    Comment *res = [[Comment alloc] init];
    NSNumber *tmp = [[NSNumber alloc] init];
    
    res.contentId = dic[@"ContentID"];
    res.content = dic[@"Content"];
    tmp = dic[@"Date"];
    res.date = [NSDate dateWithTimeIntervalSince1970:[tmp integerValue]/1000];
    res.fatherId = dic[@"FatherID"];
    res.ID = dic[@"ID"];
    tmp = dic[@"LikeNum"];
    res.likeNum = [tmp integerValue];
    res.userId = dic[@"UserID"];
    
    return res;
}

@end

@implementation ReplyRes

+(ReplyRes *) dic2Object:(NSDictionary *)dic
{
    ReplyRes *res = [[ReplyRes alloc] init];
    
    res.father = [Info dic2Object:dic[@"Father"]];
    res.user = [Info dic2Object:dic[@"User"]];
    res.reply = [Reply dic2Object:dic[@"Reply"]];
    
    return res;
}

@end

@implementation CommentRes

+(CommentRes *) dic2Object:(NSDictionary *)dic
{
    CommentRes *res = [[CommentRes alloc] init];
    
    NSLog(@"Here?");
    
    res.user = [Info dic2Object:dic[@"User"]];
    res.comment = [Comment dic2Object:dic[@"Comment"]];
    
    if ([dic[@"Replies"] isKindOfClass:[NSNull class]]) {
        res.replies = [[NSArray alloc] init];
    } else {
        NSMutableArray<ReplyRes *> *replies = [[NSMutableArray alloc] init];
        NSArray *arr = dic[@"Replies"];
        NSLog(@"arr count = %ld", arr.count);
        
        for (int i = 0; i < arr.count; i ++) {
            [replies addObject:[ReplyRes dic2Object:arr[i]]];
        }
        res.replies = [[NSArray alloc] initWithArray:replies];
    }
    
    return res;
}
@end

// nz
@implementation UserLoginInfo

+ (UserLoginInfo*) construct:(NSString*)names with:(NSString*) passwords {
    
    UserLoginInfo* userLoginInfo = [UserLoginInfo alloc];
    userLoginInfo.name = names;
    userLoginInfo.password = passwords;
    return userLoginInfo;
    
}

@end

@implementation UserInfoRes

+(UserInfoRes *) dic2Object:(NSDictionary *)dic
{
    UserInfoRes* res = [[UserInfoRes alloc] init];
    
    res.Class = dic[@"Class"];
    res.email = dic[@"Email"];
    res.ID = dic[@"ID"];
    res.name = dic[@"Name"];
    res.info = [Info dic2Object:dic[@"Info"]];
    res.maxSize = dic[@"MaxSize"];
    res.singleSize = dic[@"SingleSize"];
    res.usedSize = dic[@"UsedSize"];
    res.State = dic[@"State"];
    
    return res;
}

+ (UserInfoRes*) GetUserInfos:(NSString*) username{
    UserInfoRes* users = [UserInfoRes alloc];
    NSString *name = username;
    NSString *state = @"happy";
    users.name = name;
    users.State = state;
    return users;
}

@end

@implementation User

-(User*) initWithInfo:(Info*) info{
    if(self=[super init]){
        self.info = info;
    }
    return self;
}
+(User*) initWithInfo:(Info*) info{
    User* user = [[User alloc] initWithInfo:info];
    return user;
}

@end

@implementation NotificationRes

-(NotificationRes*)initwith:(NSString*)state andwith:(NSArray*)notification{
    self.state = state;
    self.notifications = notification;
    return self;
}

@end

@implementation File

+(File *) dic2Object:(NSDictionary *)dic
{
    File* res = [[File alloc] init];
    NSNumber *tmp = [[NSNumber alloc] init];
    
    tmp = dic[@"Count"];
    res.count = [tmp integerValue];
    res.file = dic[@"File"];
    tmp = dic[@"Size"];
    res.size = [tmp integerValue];
    tmp = dic[@"Time"];
    res.time = [NSDate dateWithTimeIntervalSince1970:[tmp integerValue]/1000];
    res.title  = dic[@"Title"];
    res.type = dic[@"Type"];
    
    return res;
}

@end

@implementation Image

+(Image *) dic2Object:(NSDictionary *)dic
{
    Image* res = [[Image alloc] init];
    NSNumber *tmp = [[NSNumber alloc] init];
    
    res.file = [File dic2Object:dic[@"File"]];
    tmp = dic[@"Native"];
    res.native = [tmp integerValue];
    res.thumb = dic[@"Thumb"];
    res.url = dic[@"URL"];
    
    return res;
}

@end
