//
//  ViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/18.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+(UserModel *)initWithDic:(NSDictionary *)dic
{
    UserModel *user = [UserModel new];
    user.userId =[NSString stringWithFormat:@"%@",dic[@"user_id"]];
    user.userImg = dic[@"user_img"];
    user.userPwd = dic[@"user_password"];
    user.userPhone = dic[@"user_phone"];
    return user;
}
@end
