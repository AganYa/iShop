//
//  ShoesViewCell.h
//  demo-微店
//
//  Created by Agan on 16/9/20.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoesViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ShoesImg;
@property (weak, nonatomic) IBOutlet UILabel *ShoesTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *ShoesPriceLab;
-(void)setUpCellWithDict:(NSDictionary *)dict;
@end
