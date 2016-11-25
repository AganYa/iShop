//
//  ViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/18.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuViewController;
@protocol MenuViewControllerDelegate <NSObject>

-(void)presentViewControllerDissmiss:(MenuViewController *)presentViewController;

@end


@interface MenuViewController : UIViewController

@property (nonatomic,weak) id <MenuViewControllerDelegate> delegate;


@end
