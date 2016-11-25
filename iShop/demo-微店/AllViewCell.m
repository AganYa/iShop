//
//  AllViewCell.m
//  demo-微店
//
//  Created by Agan on 16/9/20.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "AllViewCell.h"

@implementation AllViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)setUpCellWithDict:(NSDictionary *)dict{
    
    self.titleLab.text=dict[@"goods_title"];
    
    self.priceLab.text=dict[@"goods_price"];
    
    NSString *strURL=dict[@"goods_img"];
    
    NSArray *arr=[strURL pathComponents] ;
    
    NSString *imgaeName=[arr objectAtIndex:[arr count]-1];
    
    NSString *rootPath=NSHomeDirectory();//沙盒根目录
    
    NSString *path=[NSString stringWithFormat:@"%@/Documents/%@",rootPath,imgaeName];
    
    NSFileManager *manager=[NSFileManager defaultManager];
    
    //判断图片是否存在
    if ([manager fileExistsAtPath:path]) {
        //图片已存在的话调用沙盒图片
        self.img.image=[UIImage imageNamed:path];
        return;
        
    }
    //假如图片不存在，需要从网上下载，采用多线程下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        NSURL *url=[NSURL URLWithString:strURL];
        NSData *data=[NSData dataWithContentsOfURL:url];
        //     UIImage *image=[[UIImage alloc] initWithData:data];
        UIImage *image=[UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.img.image=image;
            [data writeToFile:path atomically:YES];
        });
    });
    
}

@end
