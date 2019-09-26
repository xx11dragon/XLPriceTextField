//
//  ViewController.m
//  XLPriceTextField
//
//  Created by Loong on 14/12/25.
//  Copyright (c) 2014年 YummyAustralia. All rights reserved.
//

#import "ViewController.h"
#import "XLPriceTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect mainRect = [UIScreen mainScreen].bounds;
    XLPriceTextField *price = [[XLPriceTextField alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    price.center = CGPointMake(mainRect.size.width / 2, mainRect.size.height / 2);
    price.placeholder = @"00.00";
    price.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:price];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
