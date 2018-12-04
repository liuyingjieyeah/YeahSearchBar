//
//  SearchHistoryTool.m
//  YeahSearchBar
//
//  Created by 微品致远 on 2018/11/28.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#import "SearchHistoryTool.h"

@interface SearchHistoryTool()

@property (strong,nonatomic) NSMutableArray *historySearchArr;

@end

@implementation SearchHistoryTool

+ (instancetype)sharedClient{
    static SearchHistoryTool *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SearchHistoryTool alloc]init];
    });
    return _sharedClient;
}

//Read
- (NSArray *)readNSUserDefaultsWithType:(HistorySearchType)type{
    
    NSString *typeStr = @"HistorySearchDefault";
    if (type == HistorySearchMessage) {
        typeStr = @"HistorySearchMessage";
    }
    //Read-倒叙输出
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    self.historySearchArr = [NSMutableArray arrayWithArray:[userDefaultes arrayForKey:typeStr]];
    NSArray* reversedArray = [[[NSArray arrayWithArray:self.historySearchArr] reverseObjectEnumerator] allObjects];
    return reversedArray;
}


//Search-Save
- (void)saveSearchInfoWithMessage:(NSString *)message type:(HistorySearchType)type{
    
    NSString *typeStr = @"HistorySearchDefault";
    if (type == HistorySearchMessage) {
        typeStr = @"HistorySearchMessage";
    }
    
    if (![self isValidWithString:message]||!self.historySearchArr) {
        return;
    }
    
    //Max-20
    if (self.historySearchArr.count >= 20) {
        [self.historySearchArr removeObjectAtIndex:0];
    }
    
    NSArray *tempArray = [NSArray arrayWithArray:self.historySearchArr];
    for (NSString *tempStr in tempArray) {
        if ([tempStr isEqualToString:message]) {
            [self.historySearchArr removeObject:tempStr];
            break;
        }
    }
    
    //Save
    [self.historySearchArr addObject:message];
    NSArray *saveArr = [NSArray arrayWithArray:self.historySearchArr];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:saveArr forKey:typeStr];
    [userDefaults synchronize];
}

- (void)cleanHistoryMethodType:(HistorySearchType)type{
    if (!self.historySearchArr) {
        return;
    }
    
    NSString *typeStr = @"HistorySearchDefault";
    if (type == HistorySearchMessage) {
        typeStr = @"HistorySearchMessage";
    }
    [self.historySearchArr removeAllObjects];
    NSArray *saveArr = [NSArray array];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:saveArr forKey:typeStr];
    [userDefaults synchronize];
    
}

- (BOOL)isValidWithString:(NSString *)str {
    if (str == nil || (NSNull *)str == [NSNull null] || str.length == 0 ) return NO;
    return YES;
}


@end

