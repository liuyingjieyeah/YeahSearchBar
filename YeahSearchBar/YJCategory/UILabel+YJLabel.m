//
//  UILabel+YJLabel.m
//  BiaoXiaoMi
//
//  Created by 刘英杰 on 2017/9/28.
//  Copyright © 2017年 刘英杰. All rights reserved.
//

#import "UILabel+YJLabel.h"

@implementation UILabel (YJLabel)

//生成Label
- (instancetype)creatLabelWithString:(NSString *)text TextColor:(UIColor *)color andFont:(UIFont *)font{
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 0;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}


+ (instancetype)creatLabelWithString:(NSString *)text TextColor:(UIColor *)color andFont:(UIFont *)font{
    return [[[self alloc]init] creatLabelWithString:text TextColor:color andFont:font];

}



@end
