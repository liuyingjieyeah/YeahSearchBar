//
//  MessageSearchCell.h
//  小移云店
//
//  Created by 微品致远 on 2018/11/29.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    MessageSearchCellDefault = 0,   //地市
    MessageSearchCellProvince,      //省内
    MessageSearchCellExpiry,        //失效
} MessageSearchCellType;

@interface MessageSearchCell : UITableViewCell

@property (nonatomic , assign) MessageSearchCellType cellType;

@property (nonatomic , strong) UILabel *titleLbl;

- (void)setData:(NSDictionary *)dataDic searchKey:(NSString *)key;

+ (MessageSearchCell *)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
