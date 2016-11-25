//
//  NewTableViewCell.h
//  demo-（网易新闻）
//
//  Created by Agan on 16/8/26.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *NewsImageView;
@property (weak, nonatomic) IBOutlet UILabel *TimeLab;
@property (weak, nonatomic) IBOutlet UILabel *TitleLab;
-(void)setUpCellWithDict:(NSDictionary *)dict;

@end
