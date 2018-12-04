//
//  YeahSearchVC.m
//  YeahSearchBar
//
//  Created by 微品致远 on 2018/11/28.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#define NavHeight 64
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "YeahSearchVC.h"
#import "YJHeader.h"
#import "SearchHistoryTool.h"
#import "MessageSearchCell.h"

@interface YeahSearchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    BOOL      searchStatus;  //搜索状态为true历史状态为false
    NSString *keyWordStr;    //搜索结果中需要标记的字体
}

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) UISearchBar *searchBar;

@property (nonatomic , strong) NSArray *sectionArr;

@property (nonatomic , strong) NSArray *hotBtnArr;

@property (nonatomic , copy)   NSString *displayPosition; //类型搜索

@property (nonatomic , strong) NSArray *hotSearchArr;     //热搜标题

@property (nonatomic , copy)   NSString *keywords;        //搜索条件

@property (nonatomic , strong) NSArray  *historyArr;      //搜索历史

@property (nonatomic , strong) NSMutableArray *dataArray; //搜索结果

@end

@implementation YeahSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.keywords = @"";
    self.displayPosition = @"";
    self.sectionArr = @[@"搜索类型",@"历史搜索"];
    self.hotSearchArr = @[@"热门",@"通知",@"政策",@"调查"];
    
    [self reloadHistoryMethod];
    
    searchStatus = false;
    
    [self setUpTheUIMethod];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!_searchBar.isFirstResponder) {
        [self.searchBar becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)setUpTheUIMethod{
    //Nav-Title
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(39 , 0, 260 , 25 )];
    [titleView addSubview:self.searchBar];
    self.navigationItem.titleView = titleView;
    //Nav-Right
    UIButton *searchBtn = [UIButton createButtonWithbackImageName:nil selectImg:nil title:@"搜索" andTitleColor:[self hexStringToColor:@"414141"] andFont:[UIFont systemFontOfSize:16 ] andTarget:self andAction:@selector(searchAction:)];
    [searchBtn setFrame:CGRectMake(0, 0, 50 , 22.5 )];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    //TableView
    [self.view addSubview:self.tableView];
}


//GetHistory
- (void)reloadHistoryMethod{
    self.historyArr = [kSearchHistoryMgr readNSUserDefaultsWithType:HistorySearchMessage];
    [self.tableView reloadData];
}


//SearchRequestMethod
- (void)searchMessageMethod{
    
    [self.searchBar resignFirstResponder];
    
    if (self.keywords.length>20) {
        //Toast
        NSLog(@"输入文本请不要超过20位");
        return;
    }
    
    //Save
    if ([self isValidWithString:self.keywords]) {
        [kSearchHistoryMgr saveSearchInfoWithMessage:self.keywords type:HistorySearchMessage];
    }
    
    keyWordStr = self.keywords;
    searchStatus = true;

    NSDictionary *param;
    param = @{@"displayPosition":self.displayPosition,
                            @"keywords":self.keywords
                            };
    
    //Save
    if ([self isValidWithString:self.keywords]) {
        [kSearchHistoryMgr saveSearchInfoWithMessage:self.keywords type:HistorySearchMessage];
    }
    //Request
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:@[@{@"isPaset":@"1",
                                            @"messageTitle":@"北京"
                                            },
                                          @{@"isPaset":@"1",
                                            @"messageTitle":@"上海"
                                            },
                                          @{@"isPaset":@"1",
                                            @"messageTitle":@"广州"
                                            },
                                          @{@"isPaset":@"2",
                                            @"messageTitle":@"深圳"
                                            },
                                          @{@"isPaset":@"2",
                                            @"messageTitle":@"杭州"
                                            }
                                          ]];
    [self.tableView reloadData];
}

//Search-Btn-Click
- (void)searchAction:(UIButton *)sender{
    
    [self searchMessageMethod];
}

//HotClick
- (void)hotLableClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    NSArray *displayArr = @[@"hot",@"notification",@"policy",@"servey"];
    if (sender.selected) {
        self.displayPosition = displayArr[sender.tag-200];
        sender.backgroundColor = [self hexStringToColor:@"547DFF"];
        [sender setTitleColor:[self hexStringToColor:@"FFFFFF"] forState:UIControlStateNormal];
    } else{
        self.displayPosition = @"";
        sender.backgroundColor = [self hexStringToColor:@"F5F5F5"];
        [sender setTitleColor:[self hexStringToColor:@"414141"] forState:UIControlStateNormal];
    }
    
    for (UIButton *btn in self.hotBtnArr) {
        if (btn != sender) {
            btn.selected = false;
            btn.backgroundColor = [self hexStringToColor:@"F5F5F5"];
            [btn setTitleColor:[self hexStringToColor:@"414141"] forState:UIControlStateNormal];
        }
    }
}


//CleanHistory
- (void)cleanHistoryMethod{
    if (self.historyArr.count>0) {
        self.historyArr = [NSArray array];
        [kSearchHistoryMgr cleanHistoryMethodType:HistorySearchMessage];
        [self.tableView reloadData];
    }
}


#pragma mark - SearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;{
    self.keywords = searchBar.text;
    if (searchBar.text.length == 0) {
        searchStatus = false;
        [self reloadHistoryMethod];
    }
}

//Keyboard-Search
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    self.keywords = searchBar.text;
    [self searchMessageMethod];
}

//Limit-Length
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (text.length == 0) {
        return YES;
    }
    NSUInteger length = searchBar.text.length + text.length;
    return length <= 20;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar resignFirstResponder];
}


#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return searchStatus ? 1 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (searchStatus) {
        return self.dataArray.count;
    }
    return section == 0 ? 1 : self.historyArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (searchStatus) {
        NSDictionary *model = self.dataArray[indexPath.row];
        MessageSearchCell *cell = [MessageSearchCell cellWithTableView:tableView];
        [cell setData:model searchKey:keyWordStr];
        return cell;
    }
    
    //Hot
    if (indexPath.section == 0) {
        UITableViewCell *sectionOneCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageSearhSecOneIden"];
        sectionOneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableArray *mutArr = [NSMutableArray array];
        for (int i = 0; i<self.hotSearchArr.count; i++) {
            NSString *title = self.hotSearchArr[i];
            UIButton *btn = [UIButton createButtonWithbackImageName:nil selectImg:nil title:title andTitleColor:[self hexStringToColor:@"414141"] andFont:[UIFont systemFontOfSize:13] andTarget:self andAction:@selector(hotLableClick:)];
            btn.tag = 200+i;
            btn.backgroundColor = [self hexStringToColor:@"F5F5F5"];
            btn.layer.masksToBounds = true;
            btn.layer.cornerRadius = 5;
            float labelW = 65;
            float labelX = (SCREEN_WIDTH/4.0-labelW)*0.5 + i*SCREEN_WIDTH/4.0;
            btn.frame = CGRectMake(labelX, 15, labelW, 26);
            [sectionOneCell.contentView addSubview:btn];
            [mutArr addObject:btn];
        }
        self.hotBtnArr = [NSArray arrayWithArray:mutArr];
        return sectionOneCell;
    }
    //History
    MessageSearchCell *cell = [MessageSearchCell cellWithTableView:tableView];
    cell.cellType = MessageSearchCellExpiry;
    cell.titleLbl.text = self.historyArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (searchStatus) {
        //Push
        NSLog(@"Push到对应的H5界面");
        return;
    }
    if (indexPath.section == 0) {
        return;
    }
    //History-Search
    self.keywords = self.historyArr[indexPath.row];
    self.searchBar.text = self.keywords;
    [self searchMessageMethod];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return searchStatus ? 0.1 : 30 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (searchStatus) {
        return [UIView new];
    }
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30 )];
    headerV.backgroundColor = [self hexStringToColor:@"FFFFFF"];
    UILabel *titleLbl = [UILabel creatLabelWithString:self.sectionArr[section] TextColor:[self hexStringToColor:@"414141"] andFont:[UIFont systemFontOfSize:14 ]];
    titleLbl.frame = CGRectMake(15 , 15 , 100, 15 );
    [headerV addSubview:titleLbl];
    if (section == 1) {
        UIButton *cleanBtn = [UIButton createButtonWithbackImageName:@"messageDelete" selectImg:nil title:@"" andTitleColor:nil andFont:nil andTarget:self andAction:@selector(cleanHistoryMethod)];
        cleanBtn.frame = CGRectMake(SCREEN_WIDTH-39, 5, 24, 24);
        [headerV addSubview:cleanBtn];
    }
    return headerV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0&&!searchStatus) {
        return 55 ;
    }
    return 49.0 ;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}


#pragma mark - lazyLoad

- (UISearchBar *)searchBar{
    
    if (!_searchBar) {
        //创建searchBar
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 260 , 25 )];
        _searchBar.backgroundImage = [UIImage new];
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        
        //默认提示文字
        _searchBar.placeholder = @"请输入你要查询的内容";
        //背景图片
        //    _searchBar = [UIImage imageNamed:@"clearImage"];
        //代理
        _searchBar.delegate = self;
        //显示右侧取消按钮
        //_searchBar.showsCancelButton = NO;
        //光标颜色
        _searchBar.tintColor = [self hexStringToColor:@"C2C2C2"];
        //拿到searchBar的输入框
        UITextField *searchTextField = [_searchBar valueForKey:@"_searchField"];
        //字体大小
        searchTextField.font = [UIFont systemFontOfSize:13 ];
        //输入框背景颜色
        searchTextField.backgroundColor = [self hexStringToColor:@"F5F5F5"];
        //圆角
        searchTextField.layer.masksToBounds = true;
        searchTextField.layer.cornerRadius = 8 ;
        /*
         //拿到取消按钮
         UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
         //设置按钮上的文字
         [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
         //设置按钮上文字的颜色
         [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];*/
    }
    return _searchBar;
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGRect tableRect = CGRectMake(0, NavHeight+5 , SCREEN_WIDTH, SCREEN_HEIGHT-NavHeight-5 );
        _tableView = [[UITableView alloc]initWithFrame:tableRect style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = YES;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellAccessoryNone;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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

- (BOOL)isValidWithString:(NSString *)str {
    if (str == nil || (NSNull *)str == [NSNull null] || str.length == 0 ) return NO;
    return YES;
}

@end
