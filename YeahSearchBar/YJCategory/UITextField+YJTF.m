//
//  UITextField+YJTF.m
//  BiaoXiaoMi
//
//  Created by 刘英杰 on 2017/9/28.
//  Copyright © 2017年 刘英杰. All rights reserved.
//

#import "UITextField+YJTF.h"

@implementation UITextField (YJTF)

//生成TextFiel
+(UITextField *)createTextFielWithFont:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]init];
    
    textField.font=font;
    
    textField.textColor=[UIColor colorWithRGBHex:0xc6c6c6];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

@end
