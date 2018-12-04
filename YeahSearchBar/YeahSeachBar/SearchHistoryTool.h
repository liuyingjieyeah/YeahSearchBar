//
//  SearchHistoryTool.h
//  YeahSearchBar
//
//  Created by 微品致远 on 2018/11/28.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

/** 将搜索记录存入UserDefaults
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HistorySearchType) {
    HistorySearchDefault = 0,   //HistorySearchDefault
    HistorySearchMessage        //HistorySearchMessage-消息搜索使用
};


@interface SearchHistoryTool : NSObject

#define kSearchHistoryMgr ([SearchHistoryTool sharedClient])

+ (instancetype)sharedClient;

/**
 *  预加载历史记录
 */
- (NSArray *)readNSUserDefaultsWithType:(HistorySearchType)typeStr;

/**
 *  搜索并保存
 */
- (void)saveSearchInfoWithMessage:(NSString *)message type:(HistorySearchType)typeStr;

/**
 *  清除全部记录
 */
- (void)cleanHistoryMethodType:(HistorySearchType)type;

@end

NS_ASSUME_NONNULL_END
