//
//  UILabel+YJLabel.h
//  BiaoXiaoMi
//
//  Created by 刘英杰 on 2017/9/28.
//  Copyright © 2017年 刘英杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YJLabel)

//生成Label
//- (UILabel *)creatLabelWithString:(NSString *)text TextColor:(UIColor *)color andFont:(UIFont *)font;

+ (instancetype)creatLabelWithString:(NSString *)text TextColor:(UIColor *)color andFont:(UIFont *)font;

@end
