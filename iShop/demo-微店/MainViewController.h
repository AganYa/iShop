//
//  ViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/18.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewTableViewCell.h"


@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
-(id)initWithTitle:(NSString *)title;
@end
