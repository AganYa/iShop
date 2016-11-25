//
//  DetailViewCell.h
//  demo-微店
//
//  Created by Agan on 16/9/20.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *NewsImageView;
@property (weak, nonatomic) IBOutlet UILabel *TimeLab;
@property (weak, nonatomic) IBOutlet UILabel *TitleLab;
-(void)setUpCellWithDict:(NSDictionary *)dict;

@end
