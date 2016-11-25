//
//  ShoesViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/18.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "ShoesViewController.h"
#import "ShoesViewCell.h"
@interface ShoesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *newsArray;
@end

@implementation ShoesViewController

-(id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tabView.delegate=self;
    self.tabView.dataSource=self;
    [self.view addSubview:self.tabView];
    [self requestNews];
}

//获取网络数据进行解析
-(void)requestNews{
    NSURL *url=[NSURL URLWithString:shoesAPI];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error!=nil) {
            NSLog(@"请求失败");
            
        }else{
            
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            self.newsArray=[dict objectForKey:@"data"];
            dispatch_async(dispatch_get_main_queue(),^{
                [self.tabView reloadData];
            });
        }
    }];
    [task resume];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;//返回数组长度，即：返回几组
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ShoesViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"shoes"];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShoesViewCell" owner:self options:nil] firstObject];
    }
    NSDictionary*dic=self.newsArray[indexPath.row];
    [cell setUpCellWithDict:dic];
    
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
