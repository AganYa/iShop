
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          //
//  ViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/18.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "MainViewController.h"
#import "MenuViewController.h"
#import "MenuPresentAnimation.h"
#import "MenuDismissAnimation.h"
#import "DetailTableViewController.h"
#import "AppDelegate.h"
@interface MainViewController ()<UIViewControllerTransitioningDelegate,MenuViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)MenuPresentAnimation *presentAnimation;
@property (nonatomic, strong) MenuDismissAnimation *dismissAnimation;
@property(nonatomic,strong)NSMutableArray *newsArray;
@end

@implementation MainViewController

-(id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.newsArray=[NSMutableArray array];
    [self requestNews];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *menu = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [menu setTitle:@"筛选" forState:normal];
    
    menu.bounds = CGRectMake(0, 0, 60, 44);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:menu];
    
    self.navigationItem.leftBarButtonItem = item;
    
    [menu addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    _presentAnimation = [MenuPresentAnimation new];
    
    _dismissAnimation = [MenuDismissAnimation new];
    
   
    
}

-(void)showMenu {
    MenuViewController *menu = [MenuViewController new];
    
    menu.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    menu.transitioningDelegate = self;
    
    menu.delegate = self;
    
    [self presentViewController:menu animated:YES completion:^{
        
    }];
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return self.presentAnimation;
}


-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
}


-(void)presentViewControllerDissmiss:(MenuViewController *)presentViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
//    NSLog(@"dissmiss");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取网络数据进行解析
-(void)requestNews{
    NSURL *url=[NSURL URLWithString:Title];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error!=nil) {
            NSLog(@"请求失败");
            
        }else{
            
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         
            self.newsArray=[dict objectForKey:@"data"];
            
            dispatch_async(dispatch_get_main_queue(),^{
                 [self.tableView reloadData];
            });
        }
    }];
    [task resume];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.newsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    
    cell.tag=100+indexPath.row;
    NSDictionary *dict=[self.newsArray objectAtIndex:indexPath.row];
    [cell setUpCellWithDict:dict];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict=[self.newsArray objectAtIndex:indexPath.row];
    DetailTableViewController*detail=(DetailTableViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    detail.dic=dict;
    [self.navigationController pushViewController:detail animated:YES];
    
}




@end
