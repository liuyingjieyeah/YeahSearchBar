//
//  UIImageView+YJImageView.h
//  智汇随身厅
//
//  Created by 刘英杰 on 2018/3/20.
//  Copyright © 2018年 vivian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (YJImageView)

//生成imageView
+ (UIImageView *)createImageViewWithName:(NSString *)imageName color:(UIColor *)color;

@end
