//
//  InfoViewController.h
//  demo-微店
//
//  Created by Agan on 16/9/20.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
@property(nonatomic,strong) NSString *info;

- (IBAction)Return:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property(nonatomic,strong) UIImage *img;
@property(nonatomic,strong) UIImageView *imgs;

@end
