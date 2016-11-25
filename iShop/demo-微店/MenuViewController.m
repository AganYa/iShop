//
//  ViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/18.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "MenuViewController.h"
#import "AllViewController.h"
#import "ShoesViewController.h"
#import "PantsViewController.h"
#import "CoatViewController.h"
#import "MainViewController.h"
@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *whiteBgview;
@property (nonatomic,strong)UIView *blackTranslucentBackground;
@property (nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong) UIImage *image;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _titleArray = @[@"全部",@"鞋子",@"上衣",@"裤子"];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    self.view.clipsToBounds = NO;
    
    _whiteBgview = [UIView new];
    
    _whiteBgview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.35, [UIScreen mainScreen].bounds.size.height);
    
    _whiteBgview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_whiteBgview];
    
    
    //手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    [_whiteBgview addGestureRecognizer:panGestureRecognizer];
  
    UITableView *tableView = [[UITableView alloc] initWithFrame:_whiteBgview.bounds style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [_whiteBgview addSubview:tableView];
    
    tableView.backgroundColor  = [UIColor colorWithRed:73/255.0 green:68/255.0 blue:65/255.0 alpha:1];
    
    
    
}

//处理手势
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:_whiteBgview];
    NSLog(@"%f",translation.x);
    if (_whiteBgview.frame.origin.x <= 0) {
        
        if (_whiteBgview.frame.origin.x + translation.x > 0) {
            return;
        }
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                             recognizer.view.center.y );
        [recognizer setTranslation:CGPointZero inView:_whiteBgview];
    }
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (-_whiteBgview.frame.origin.x >= _whiteBgview.frame.size.width/2.0) {
            [UIView animateWithDuration:0.2 animations:^{
                _whiteBgview.frame = CGRectMake(-_whiteBgview.frame.size.width, 0, _whiteBgview.frame.size.width, _whiteBgview.frame.size.height);
                
                if ([self.delegate respondsToSelector:@selector(presentViewControllerDissmiss:)]) {
                    [self.delegate presentViewControllerDissmiss:self];
                }

            } completion:^(BOOL finished) {
                 _whiteBgview.frame = CGRectMake(0, 0, _whiteBgview.frame.size.width, _whiteBgview.frame.size.height);
            }];
            
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                _whiteBgview.frame = _whiteBgview.bounds;
                
            }];
        }
    }
    
}





//view 手势
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 拿到UITouch就能获取当前点
    UITouch *touch = [touches anyObject];
    // 获取当前点
    CGPoint curP = [touch locationInView:_whiteBgview];
    // 获取上一个点
    CGPoint preP = [touch previousLocationInView:_whiteBgview];
    // 获取手指x轴偏移量
    CGFloat offsetX = curP.x - preP.x;
    // 获取手指y轴偏移量
    // 移动当前view
    if (_whiteBgview.frame.origin.x + offsetX <=0) {
        _whiteBgview.transform = CGAffineTransformTranslate(_whiteBgview.transform, offsetX, 0);

    }
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (_whiteBgview.frame.origin.x <= (-_whiteBgview.frame.size.width/2.0)) {
        [UIView animateWithDuration:0.25 animations:^{
            _whiteBgview.frame = CGRectMake(-_whiteBgview.frame.size.width, 0, _whiteBgview.frame.size.width, _whiteBgview.frame.size.height);
            
            if ([self.delegate respondsToSelector:@selector(presentViewControllerDissmiss:)]) {
                [self.delegate presentViewControllerDissmiss:self];
            }
            
        } completion:^(BOOL finished) {
            _whiteBgview.frame = CGRectMake(0, 0, _whiteBgview.frame.size.width, _whiteBgview.frame.size.height);
            
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            _whiteBgview.frame = _whiteBgview.bounds;
            
        }];
    }

    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idf = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idf];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idf];
    }
    
    cell.textLabel.text = _titleArray[indexPath.row];
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 188;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"indexPath.row:%ld",(long)indexPath.row);
    
    if ([self.delegate respondsToSelector:@selector(presentViewControllerDissmiss:)]) {
        
        [self.delegate presentViewControllerDissmiss:self];
    }
    if (indexPath.row==0) {
        AllViewController *second = [[AllViewController alloc] initWithTitle:_titleArray[0]];
        
        UINavigationController *nav = (UINavigationController *)self.nextResponder;
        
        [nav pushViewController:second animated:YES];
    }else if (indexPath.row==1){
        ShoesViewController *second1 = [[ShoesViewController alloc] initWithTitle:_titleArray[1]];
        
        UINavigationController *nav1 = (UINavigationController *)self.nextResponder;
        
        [nav1 pushViewController:second1 animated:YES];
    }else if (indexPath.row==2){
 
    CoatViewController *second2 = [[CoatViewController alloc] initWithTitle:_titleArray[2]];
    
    UINavigationController *nav2 = (UINavigationController *)self.nextResponder;
    
    [nav2 pushViewController:second2 animated:YES];
    }else {
    PantsViewController *second3 = [[PantsViewController alloc] initWithTitle:_titleArray[3]];
    
    UINavigationController *nav3 = (UINavigationController *)self.nextResponder;
    
    [nav3 pushViewController:second3 animated:YES];
    }
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 2, [UIScreen mainScreen].bounds.size.height);

}

@end
