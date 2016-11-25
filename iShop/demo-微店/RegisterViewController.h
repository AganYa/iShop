//
//  RegisterViewController.h
//  demo-微店
//
//  Created by Agan on 16/9/18.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ViewControllerDelegate <NSObject>

-(void)name:(NSString *)name andMima:(NSString *)mima;

@end
@interface RegisterViewController : UIViewController
@property(nonatomic,strong)id<ViewControllerDelegate>delegate;


@property (weak, nonatomic) IBOutlet UITextField *typeMima;

@property (weak, nonatomic) IBOutlet UITextField *queding;

@property (weak, nonatomic) IBOutlet UITextField *PhoneNum;

@property (weak, nonatomic) IBOutlet UITextField *YZMLab;
- (IBAction)zhuce:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *duanxinBtn;
@end
