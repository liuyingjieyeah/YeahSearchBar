//
//  UIColor+ColorTools.m
//  BiaoXiaoMi
//
//  Created by 刘英杰 on 2017/9/28.
//  Copyright © 2017年 刘英杰. All rights reserved.
//

#import "UIColor+ColorTools.h"

@implementation UIColor (ColorTools)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

@end
