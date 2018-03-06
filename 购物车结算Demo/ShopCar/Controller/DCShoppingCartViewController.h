//
//  DCShoppingCartViewController.h
//  购物车结算Demo
//
//  Created by wenhua on 2018/3/6.
//  Copyright © 2018年 wenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCShoppingCartViewController : UIViewController

@property (strong, nonatomic) UIView *naviView;
@property (strong, nonatomic) UIButton *returnBtn;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *editLabel;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIImageView *allImage;
@property (strong, nonatomic) UIButton *allBtn;
@property (strong, nonatomic) UILabel *allPriceLabel;
@property (strong, nonatomic) UILabel *subLabel;
@property (strong, nonatomic) UIButton *settlementButton;
@property (strong, nonatomic) UILabel *settlementLabel;


@end
