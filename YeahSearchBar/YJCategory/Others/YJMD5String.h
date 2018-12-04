//
//  YJMD5String.h
//  小移云店
//
//  Created by 微品致远 on 2018/9/13.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJMD5String : NSObject

// MD5加密
/*
 *由于MD5加密是不可逆的,多用来进行验证
 */
// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;

@end
