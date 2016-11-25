//
//  ViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/18.
//  Copyright © 2016年 Agan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UserModel : NSObject
@property (nonatomic) NSString *userId;
@property (nonatomic,strong) NSString *userPhone;
@property (nonatomic,strong) UIImage *userImg;
@property (nonatomic,strong) NSString *userPwd;
+(UserModel *)initWithDic:(NSDictionary*)dic;
@end
