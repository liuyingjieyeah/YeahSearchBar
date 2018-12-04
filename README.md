# YeahSearchBar
UISearchBar+History+TableView

![image.png](https://upload-images.jianshu.io/upload_images/1858764-19ddfe4f18589605.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 一、SearchBar
```
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
```
UITableView继承UIScrollView，所以可以使用其代理取消键盘响应
```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}
```

---
### 二、搜索历史记录存储UserDefaults
![SearchHistoryTool.png](https://upload-images.jianshu.io/upload_images/1858764-bb6111523f1dceac.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
typedef NS_ENUM(NSInteger,HistorySearchType) {
    HistorySearchDefault = 0,   //HistorySearchDefault
    HistorySearchMessage        //HistorySearchMessage-消息搜索使用
};
@property (strong,nonatomic) NSMutableArray *historySearchArr;
```
### 读（按照时间顺序）
```
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
```
### 写（最多存储20条）
```
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
```
### 删
```
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
```

[参考链接](https://www.cnblogs.com/wsnb/p/5341816.html )
