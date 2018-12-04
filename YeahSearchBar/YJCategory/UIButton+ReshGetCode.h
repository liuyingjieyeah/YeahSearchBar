//
//  UIButton+ReshGetCode.h
//  BiaoXiaoMi
//
//  Created by 刘英杰 on 2017/9/27.
//  Copyright © 2017年 刘英杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ReshGetCode)

/**
 按钮倒计时的问题
 @param countDownTime 倒计时的时间(分钟)
 */
- (void)buttonWithTime:(CGFloat)countDownTime;

/**
 生成Button
 */
+ (UIButton *)createButtonWithbackImageName:(NSString *)imageName selectImg:(NSString *)selectImg title:(NSString *)title andTitleColor:(UIColor *)color andFont:(UIFont *)font andTarget:(id)target andAction:(SEL)action;



@end
