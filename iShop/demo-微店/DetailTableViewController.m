//
//  DetailTableViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/20.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "DetailTableViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "AppDelegate.h"
@interface DetailTableViewController ()
@property(nonatomic,strong)NSMutableArray *newsArray;

- (IBAction)AddGoodCar:(UIButton *)sender;
@property(nonatomic,strong) NSDictionary *dict;
@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setUpCellWithDict:self.dic];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)setUpCellWithDict:(NSDictionary *)dict{
    
    self.TitlesLab.text=dict[@"goods_title"];
    
    self.Price.text=dict[@"goods_price"];
    
    NSString *strURL=dict[@"goods_img"];
    
    NSArray *arr=[strURL pathComponents] ;
    
    NSString *imgaeName=[arr objectAtIndex:[arr count]-1];
    
    NSString *rootPath=NSHomeDirectory();//沙盒根目录
    
    NSString *path=[NSString stringWithFormat:@"%@/Documents/%@",rootPath,imgaeName];
    
    NSFileManager *manager=[NSFileManager defaultManager];
    
    //判断图片是否存在
    if ([manager fileExistsAtPath:path]) {
        //图片已存在的话调用沙盒图片
        self.imageViews.image=[UIImage imageNamed:path];
        return;
        
    }
    //假如图片不存在，需要从网上下载，采用多线程下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        NSURL *url=[NSURL URLWithString:strURL];
        NSData *data=[NSData dataWithContentsOfURL:url];
        //     UIImage *image=[[UIImage alloc] initWithData:data];
        UIImage *image=[UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageViews.image=image;
            [data writeToFile:path atomically:YES];
        });
    });
    
}


- (void)requestRegister{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //必须设置
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *urlPath = [NSString stringWithFormat:AddGoodCarAPI];
    if (APPDELEGATE.user.userId==NULL) {
        self.dict=nil;
    }else{
  
        self.dict = @{@"userid":APPDELEGATE.user.userId,
                      @"goodsid":[self.dic objectForKey:@"goods_id"]};
    }
    [manager POST:urlPath parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSString *str = [NSString stringWithFormat:@"%@",[responseDic valueForKey:@"code"]];
        
        if ([str isEqualToString:@"200"]) {
            [self alert:@"加入成功！"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败，请检查网络!%@",error);
    }];
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

- (IBAction)AddGoodCar:(UIButton *)sender {
    if (APPDELEGATE.user.userPhone ==nil) {
        [self alert:@"亲，登录后才能加入哟~"];
    }else{
    [self requestRegister];
    }
}
@end
