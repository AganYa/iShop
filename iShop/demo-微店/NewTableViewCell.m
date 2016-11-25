//
//  NewTableViewCell.m
//  demo-（网易新闻）
//
//  Created by Agan on 16/8/26.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "NewTableViewCell.h"

@implementation NewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(void)setUpCellWithDict:(NSDictionary *)dict{
    
    self.TitleLab.text=dict[@"goods_title"];
    
    self.TimeLab.text=dict[@"goods_price"];
    
    NSString *strURL=dict[@"goods_img"];
    
    NSArray *arr=[strURL pathComponents] ;
    
    NSString *imgaeName=[arr objectAtIndex:[arr count]-1];
    
    NSString *rootPath=NSHomeDirectory();//沙盒根目录
    
    NSString *path=[NSString stringWithFormat:@"%@/Documents/%@",rootPath,imgaeName];
   // NSLog(@"沙盒路径=%@",path);
    NSFileManager *manager=[NSFileManager defaultManager];
    
    //判断图片是否存在
    if ([manager fileExistsAtPath:path]) {
        //图片已存在的话调用沙盒图片
        self.NewsImageView.image=[UIImage imageNamed:path];
        return;
        
    }
    //假如图片不存在，需要从网上下载，采用多线程下载图片
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
         NSURL *url=[NSURL URLWithString:strURL];
         NSData *data=[NSData dataWithContentsOfURL:url];
    //     UIImage *image=[[UIImage alloc] initWithData:data];
         UIImage *image=[UIImage imageWithData:data];
         dispatch_async(dispatch_get_main_queue(), ^{
             self.NewsImageView.image=image;
             [data writeToFile:path atomically:YES];
         });
     });
  
}




@end
