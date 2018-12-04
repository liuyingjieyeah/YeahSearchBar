//
//  MessageSearchCell.m
//  小移云店
//
//  Created by 微品致远 on 2018/11/29.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "MessageSearchCell.h"
#import "YJHeader.h"

@interface MessageSearchCell()

@property (nonatomic , strong) UIView *lineView;

@end

@implementation MessageSearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addTheUIMethod];
    }
    return self;
}

- (void)setData:(NSDictionary *)dataDic searchKey:(NSString *)key{
    
    NSString *titleString = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"messageTitle"]];

    //失效
    if ([[dataDic objectForKey:@"isPaset"] isEqualToString:@"2"]) {
        _titleLbl.textColor = [self hexStringToColor:@"999999"];
        titleString = [NSString stringWithFormat:@"%@（已过期）",titleString];
        _titleLbl.text = titleString;
    }else{
        NSRange keyWordRange = [titleString rangeOfString:key];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        NSDictionary *ats = @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                               NSParagraphStyleAttributeName : paragraphStyle,
                              NSForegroundColorAttributeName:[self hexStringToColor:@"414141"]
                               };
        NSMutableAttributedString *cardNumAttStr = [[NSMutableAttributedString alloc]initWithString:titleString attributes:ats];
        [cardNumAttStr addAttribute:NSForegroundColorAttributeName value:[self hexStringToColor:@"FF9646"] range:keyWordRange];
        _titleLbl.attributedText = cardNumAttStr;
    }
}

- (void)setCellType:(MessageSearchCellType)cellType{
    _cellType = cellType;
    if (cellType == MessageSearchCellExpiry) {
        _titleLbl.textColor = [self hexStringToColor:@"999999"];
    }
}

- (void)addTheUIMethod{

    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.lineView];
}

+ (MessageSearchCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"MessageSearCelIdentType";
    MessageSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MessageSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


#pragma mark - lazyLoad

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [self hexStringToColor:@"E0DFDF" ];
        _lineView.frame = CGRectMake(15, self.contentView.frame.size.height-1, SCREEN_WIDTH-30, 0.5);
    }
    return _lineView;
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel creatLabelWithString:@"" TextColor:[self hexStringToColor:@"414141"] andFont:[UIFont systemFontOfSize:14]];
        _titleLbl.numberOfLines = 0;
        _titleLbl.frame = CGRectMake(15, (self.contentView.frame.size.height-15)*0.5, SCREEN_WIDTH-30, 15);
    }
    return _titleLbl;
}

//ColorTool
- (UIColor *)hexStringToColor:(NSString *)stringToConvert{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
