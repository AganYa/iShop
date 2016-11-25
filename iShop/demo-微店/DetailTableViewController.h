//
//  DetailTableViewController.h
//  demo-微店
//
//  Created by Agan on 16/9/20.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageViews;
@property (weak, nonatomic) IBOutlet UILabel *TitlesLab;

@property (weak, nonatomic) IBOutlet UILabel *Price;
-(void)setUpCellWithDict:(NSDictionary *)dict;
@property(nonatomic,strong) NSDictionary *dic;
@end
