//
//  UIImageView+YJImageView.m
//  智汇随身厅
//
//  Created by 刘英杰 on 2018/3/20.
//  Copyright © 2018年 vivian. All rights reserved.
//

#import "UIImageView+YJImageView.h"

@implementation UIImageView (YJImageView)

+ (UIImageView *)createImageViewWithName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView = [[UIImageView alloc]init];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    return imageView;
}

@end
