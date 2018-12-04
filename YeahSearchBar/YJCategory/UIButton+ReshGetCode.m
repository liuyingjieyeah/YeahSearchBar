//
//  UIButton+ReshGetCode.m
//  BiaoXiaoMi
//
//  Created by 刘英杰 on 2017/9/27.
//  Copyright © 2017年 刘英杰. All rights reserved.
//

#define GET_CODE_COLOR      [UIColor colorWithRed:0/255.0 green:132/255.0 blue:207/255.0 alpha:1/1.0]

#import "UIButton+ReshGetCode.h"

/** 倒计时的显示时间 */
static NSInteger secondsCountDown;
/** 记录总共的时间 */
static NSInteger allTime;

@implementation UIButton (ReshGetCode)

- (void)buttonWithTime:(CGFloat)countDownTime {

    self.userInteractionEnabled = NO;
    secondsCountDown = 60 * countDownTime;
    allTime = 60 * countDownTime;
    [self setTitle:[NSString stringWithFormat:@"重新发送(%lds)",secondsCountDown] forState:UIControlStateNormal];
    [self setTitleColor:GET_CODE_COLOR forState:UIControlStateNormal];     //[UIColor colorWithRGBHex:0x999999]
    [self.layer setMasksToBounds:YES];
//    [self.layer setCornerRadius:5.0];
    [self.layer setBorderColor:GET_CODE_COLOR.CGColor];                    //[UIColor colorWithRGBHex:0x999999]
//    self.layer.borderWidth = 1.f;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod:) userInfo:nil repeats:YES];
}
-(void)timeFireMethod:(NSTimer *)countDownTimer{
    //倒计时-1
    secondsCountDown--;
    //修改倒计时标签现实内容
    [self setTitle:[NSString stringWithFormat:@"重新发送(%lds)",secondsCountDown] forState:UIControlStateNormal];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown == 0){
        [countDownTimer invalidate];
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        [self setTitleColor:GET_CODE_COLOR forState:UIControlStateNormal];
        secondsCountDown = allTime;
        self.userInteractionEnabled = YES;
    }
}

//生成Button
+ (UIButton *)createButtonWithbackImageName:(NSString *)imageName selectImg:(NSString *)selectImg title:(NSString *)title andTitleColor:(UIColor *)color andFont:(UIFont *)font andTarget:(id)target andAction:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (selectImg) {
        [btn setBackgroundImage:[UIImage imageNamed:selectImg] forState:UIControlStateSelected];
//        [btn setImage:[UIImage imageNamed:selectImg] forState:UIControlStateNormal];
    }
    if (font)
    {
        btn.titleLabel.font=font;
    }
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}


@end
