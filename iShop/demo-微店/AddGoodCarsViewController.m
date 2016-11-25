//
//  AddGoodCarsViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/20.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "AddGoodCarsViewController.h"
#import "ShoesViewCell.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "AppDelegate.h"
#import "NewTableViewCell.h"
@interface AddGoodCarsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *newsArray;
@property (weak, nonatomic) IBOutlet UITableView *mainTableview;
@property(nonatomic,strong) NSDictionary *dict;

@end

@implementation AddGoodCarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableview.dataSource = self;
    self.mainTableview.delegate = self;
    self.newsArray=[NSMutableArray array];
    [self requestRegister];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)requestRegister{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //必须设置
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
//    NSString *urlPath = [NSString stringWithFormat:selectAPI];
    
    if (APPDELEGATE.user.userId==nil) {
        self.dict=nil ;
    }else{
        
    self.dict = @{@"userid":APPDELEGATE.user.userId};
       
    }
    
    
    [manager POST:selectAPI parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {


        NSDictionary *responseDic = (NSDictionary *)responseObject;
        self.newsArray=[responseDic objectForKey:@"data"];
        [self.mainTableview reloadData];
        NSString *str = [NSString stringWithFormat:@"%@",[responseDic valueForKey:@"code"]];
   
        if ([str isEqualToString:@"200"]) {
            //[self alert:@"加入成功！"];
        }
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            
        });

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败，请检查网络!%@",error);
    }];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.newsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    
    
   NSDictionary *dict=[self.newsArray objectAtIndex:indexPath.row];
    [cell setUpCellWithDict:dict];
    
    return cell;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 107;
//}

//Alert方法
-(void)alert:(NSString *)mes{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:mes preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [controll addAction:action1];
    [controll addAction:action2];
    
    [self presentViewController:controll animated:YES completion:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    [self requestRegister];

    
}

@end
