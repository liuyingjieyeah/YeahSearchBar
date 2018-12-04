//
//  UIColor+ColorTools.h
//  BiaoXiaoMi
//
//  Created by 刘英杰 on 2017/9/28.
//  Copyright © 2017年 刘英杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorTools)

/**
 *  根据十六进制转换成UIColor
 *
 *  @param hex UIColor的十六进制
 *
 *  @return 转换后的结果
 */
+(UIColor *)colorWithRGBHex:(UInt32)hex;

@end
