//
//  ViewController.m
//  YeahSearchBar
//
//  Created by 微品致远 on 2018/11/28.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //未使用Push
}

- (IBAction)SearchButton:(id)sender {
    
    [self.navigationController pushViewController:NSClassFromString(@"YeahSearchVC").new animated:true];
}

@end
