//
//  InfoViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/20.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "InfoViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
@interface InfoViewController ()
@property (weak, nonatomic) IBOutlet UIView *Views;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(void)viewDidAppear:(BOOL)animated
{
    if (APPDELEGATE.user.userImg==nil && APPDELEGATE.user.userPhone == nil) {
        self.phone.text = @"未登录";
        UIImage *img=[UIImage imageNamed:@"头像.png"];
        self.imgs=[[[UIImageView alloc] initWithFrame:CGRectMake(14, 29, 70, 70)] initWithImage:img];
        [self.Views addSubview:self.imgs];
        
    }else{
        
    self.phone.text = APPDELEGATE.user.userPhone;
    NSString *path=(NSString *)APPDELEGATE.user.userImg;
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc]initWithData:data];
    self.imgs.image=image;
        
    }
}

- (IBAction)Return:(UIButton *)sender {

    self.imgs.image=nil;
    APPDELEGATE.user=nil;
    self.phone.text = @"未登录";
    UIImage *img=[UIImage imageNamed:@"头像.png"];
    self.imgs=[[[UIImageView alloc] initWithFrame:CGRectMake(14, 29, 70, 70)] initWithImage:img];
    [self.Views addSubview:self.imgs];


}
@end
