//
//  RegisterViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/18.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "CaptchaView.h"
#import "AppDelegate.h"

@interface RegisterViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    CaptchaView *_captchaView;
    UITextField *_input;
}
@property (weak, nonatomic) IBOutlet UILabel *TimeLab;
@property(nonatomic,strong)NSTimer *timer;//计数器
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int ture1;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self chuanjian];
    self.ture1 = 1;
    self.PhoneNum.delegate = self;
    self.x = 60;
    
    
}
-(void)chuanjian
{
    //显示验证码界面
    _captchaView = [[CaptchaView alloc] initWithFrame:CGRectMake(0.0001, 0.0001, 0.0001, 0.0001)];
    _captchaView.backgroundColor=nil;
    [self.view addSubview:_captchaView];
    
    
    
}
//#pragma mark --验证码
//-(void)yanzhengBtn{
//    NSLog(@"_input.text------%@",_input.text);
//    NSLog(@"_captchaView.changeString---%@",_captchaView.changeString);
//    //判断输入的是否为验证图片显示的验证码
//    if ([_input.text isEqualToString:_captchaView.changeString]) {
//        //正确弹出警告款提示正确
//        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"恭喜您 ^o^" message:@"验证成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alview show];
//    }
//    else
//    {
//        //验证不匹配，验证码和输入框晃动
//        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
//        anim.repeatCount = 1;
//        anim.values = @[@-20, @20, @-20];
//        [_captchaView.layer addAnimation:anim forKey:nil];
//        [_input.layer addAnimation:anim forKey:nil];
//    }
//    
//}



- (void)requestRegister{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //必须设置
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *urlPath = [NSString stringWithFormat:Register];
    
    NSDictionary *dict = @{@"tel":self.PhoneNum.text,
                           @"pwd":self.typeMima.text};
    [manager POST:urlPath parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSString *str = [NSString stringWithFormat:@"%@",[responseDic valueForKey:@"code"]];
        APPDELEGATE.user.userPhone=[[responseDic objectForKey:@"data"] objectForKey:@"user_phone"];
        NSLog(@"手机号码%@",APPDELEGATE.user.userPhone);
        if ([str isEqualToString:@"200"]) {
            
         [self.navigationController popViewControllerAnimated:YES];
            
        }else if([str isEqualToString:@"300"]){
            [self alert:@"手机号已存在"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败，请检查网络!%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//限制手机号码11位数
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.PhoneNum.text.length+string.length <= 11) {
        return YES  ;
    }else{
        [self alert:@"号码过长"];
        return NO;
    }
    return YES;
}


//Alert方法
-(void)alert:(NSString *)mes{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:mes preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [controll addAction:action1];
    [controll addAction:action2];
    
    [self presentViewController:controll animated:YES completion:nil];
}

//注册按钮
- (IBAction)zhuce:(UIButton *)sender {
    
    if ([self.PhoneNum.text isEqualToString:@""]) {
        
        [self alert:@"手机号不能为空!"];
        
        }
    if([self.typeMima.text isEqualToString:@""]){
            [self alert:@"密码不能为空"];
        }
    if([self.queding.text isEqualToString:@""]){
            [self alert:@"确定密码不能为空"];
        }
    if (![self.typeMima.text isEqualToString:self.queding.text]) {
        [self alert:@"密码不一致!"];
    }
     if(self.PhoneNum.text.length < 11){
            [self alert:@"手机号码不正确"];
        }
    if ([self.YZMLab.text isEqualToString:@""]) {
        [self alert:@"验证码不能为空!"];
    }
    
    if([_captchaView.changeString isEqualToString:(NSMutableString *)self.YZMLab.text]){
        
        [self requestRegister];
        
        
    }else if(![_captchaView.changeString isEqualToString:(NSMutableString *)self.YZMLab.text]){
        [self alert:@"验证码有误！"];
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [_captchaView.layer addAnimation:anim forKey:nil];
        [_input.layer addAnimation:anim forKey:nil];
        
    }
}

//发送短信 计时器
- (IBAction)duamxin:(UIButton *)sender {
    
    NSLog(@"验证码:%@",_captchaView.changeString);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daoji) userInfo:nil repeats:YES];
    [self.duanxinBtn setEnabled:NO];
    
}
//计数方法
-(void)daoji{
    self.duanxinBtn.tintColor = [UIColor grayColor];
    self.x--;
    if (self.x != 0) {
        self.TimeLab.text = [NSString stringWithFormat:@"%dS",self.x];
    }else{
        [self.duanxinBtn setEnabled:YES];
        [self.timer invalidate];
        self.TimeLab.text = [NSString stringWithFormat:@"重新发送"];
        self.x = 60;
    }
    
    
}

@end
