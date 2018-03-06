//
//  ViewController.m
//  购物车结算Demo
//
//  Created by wenhua on 2018/3/6.
//  Copyright © 2018年 wenhua. All rights reserved.
//

#import "ViewController.h"
#import "DCShoppingCartViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *shopCarBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 150, 155, 55)];
    shopCarBtn.backgroundColor = [UIColor redColor];
    [shopCarBtn setTitle:@"购物车" forState:UIControlStateNormal];
    [shopCarBtn addTarget:self action:@selector(shopCarBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopCarBtn];
}

-(void)shopCarBtnDidClick
{
    DCShoppingCartViewController *shopVC = [[DCShoppingCartViewController alloc]init];
    [self presentViewController:shopVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
