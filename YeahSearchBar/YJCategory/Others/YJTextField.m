//
//  YJTextField.m
//  YeahSearchBar
//
//  Created by 微品致远 on 2018/9/25.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#import "YJTextField.h"

@implementation YJTextField

/*
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(paste:))//禁止粘贴
        return NO;
    if (action == @selector(select:))// 禁止选择
        return NO;
    if (action == @selector(selectAll:))// 禁止全选
        return NO;
    return [super canPerformAction:action withSender:sender];
}*/

//整体禁止
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}


@end
