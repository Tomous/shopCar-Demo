//
//  DCShoppingCartViewController.m
//  购物车结算Demo
//
//  Created by wenhua on 2018/3/6.
//  Copyright © 2018年 wenhua. All rights reserved.
//

#import "DCShoppingCartViewController.h"
#import "Util.h"
#import "Header.h"
#import "DCShoppingTableView.h"
#import "DCShoppingModel.h"
#import "UIView+Extension.h"
@interface DCShoppingCartViewController ()
{
    
    BOOL isbool;
    
    BOOL editbool;
    
    NSString *numString;
    
    DCShoppingTableView *shopping;
    
    NSArray *cellArray;
}
@end

@implementation DCShoppingCartViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
    [self setInit];
}

-(void)setUpUI
{
    ///---------navView------
    _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_naviView];
    
    _returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 20, 44, 44)];
    [_returnBtn addTarget:self action:@selector(returnBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [_returnBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [_naviView addSubview:_returnBtn];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.width = 207;
    _titleLabel.height = 21;
    _titleLabel.y = 32;
    _titleLabel.x = (SCREEN_WIDTH - _titleLabel.width) / 2;
    _titleLabel.text = @"购物车";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    [_naviView addSubview:_titleLabel];
    
    _editLabel = [[UIButton alloc]init];
    _editLabel.width = 44;
    _editLabel.height = _editLabel.width;
    _editLabel.x = (SCREEN_WIDTH - _editLabel.width - 2);
    _editLabel.y = 20;
    [_editLabel setTitle:@"编辑" forState:UIControlStateNormal];
    [_editLabel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_editLabel addTarget:self action:@selector(editBtn) forControlEvents:UIControlEventTouchUpInside];
    [_naviView addSubview:_editLabel];
    
    
    ///-----------bottomView-------
    _bottomView = [[UIView alloc]init];
    _bottomView.width = self.view.width;
    _bottomView.height = 55;
    _bottomView.x = 0;
    _bottomView.y = self.view.height - _bottomView.height;
    [self.view addSubview:_bottomView];
    
    _allImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 25, 25)];
    [_allImage setImage:[UIImage imageNamed:@"iconfont-yuanquan"]];
    [_allImage setHighlightedImage:[UIImage imageNamed:@"iconfont-zhengque"]];
    
    _allBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 89, 55)];
    [_allBtn setTitle:@"全选" forState:UIControlStateNormal];
    _allBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_allBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_allBtn addTarget:self action:@selector(allBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_allBtn];
    [_allBtn addSubview:_allImage];
    
    _allPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_allBtn.frame) + 4, 8, 172, 21)];
    _allPriceLabel.backgroundColor = [UIColor whiteColor];
    _allPriceLabel.text = @"总价: ￥0.00";
    _allPriceLabel.textAlignment = NSTextAlignmentRight;
    [_bottomView addSubview:_allPriceLabel];
    
    _subLabel = [[UILabel alloc]initWithFrame:CGRectMake(_allPriceLabel.x, CGRectGetMaxY(_allPriceLabel.frame) + 2, _allPriceLabel.width, _allPriceLabel.height)];
    _subLabel.backgroundColor = [UIColor whiteColor];
    _subLabel.textAlignment = NSTextAlignmentRight;
    _subLabel.text = @"未享受优惠";
    [_bottomView addSubview:_subLabel];
    
    _settlementButton = [[UIButton alloc]init];
    _settlementButton.width = 103;
    _settlementButton.height = 55;
    _settlementButton.x = SCREEN_WIDTH - _settlementButton.width - 2;
    _settlementButton.y = 0;
    [_settlementButton addTarget:self action:@selector(settlementBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    _settlementButton.backgroundColor = [UIColor redColor];
    [_bottomView addSubview:_settlementButton];
    
    _settlementLabel = [[UILabel alloc]initWithFrame:_settlementButton.frame];
    _settlementLabel.textColor = [UIColor lightGrayColor];
    _settlementLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomView addSubview:_settlementLabel];
}
-(void)setInit{
    
    numString = @"0";
    [Util setFoursides:_bottomView Direction:@"top" sizeW:SCREEN_WIDTH];
    [Util setFoursides:_naviView Direction:@"bottom" sizeW:SCREEN_WIDTH];
    
    shopping = [[DCShoppingTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -50) style:UITableViewStyleGrouped];
    [self.view addSubview:shopping];
    
    [self setData];
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllPrice:) name:@"AllPrice" object:nil];
    [Util setUILabel:_allPriceLabel Data:@"总价: " SetData:@"￥0.00" Color:BACKGROUNDCOLOR Font:15 Underline:NO];
    
}
#pragma mark 通知
- (void)AllPrice:(NSNotification *)text{
    
    _allPriceLabel.text = [NSString stringWithFormat:@"总价: %@",text.userInfo[@"allPrice"]];
    [Util setUILabel:_allPriceLabel Data:@"总价: " SetData:text.userInfo[@"allPrice"] Color:BACKGROUNDCOLOR Font:15 Underline:NO];
    
    numString = text.userInfo[@"num"];
    
    [self setTlementLabel];
    [self setAllBtnState:[text.userInfo[@"allState"]  isEqual: @"YES"]?NO:YES];
    
    cellArray =  text.userInfo[@"cellModel"];
}
#pragma mark 设置结算按钮状态
-(void)setTlementLabel{
    
    NSString *string = editbool?@"删除":@"结算";
    _settlementLabel.text = [NSString stringWithFormat:@"%@(%@)",string,numString];
}
#pragma mark 数据
-(void)setData{
    
    
    NSDictionary *dicts = @{
                            @"item":@[
                                    @{
                                        @"headID":@"10",
                                        @"headState":@1,
                                        @"discount":@"9",
                                        @"headCellArray":@[
                                                @{
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@2,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@1,
                                                    @"ID":@"10",
                                                    },
                                                @{
                                                    
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@2,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@1,
                                                    @"ID":@"11",
                                                    },
                                                @{
                                                    
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@2,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@0,
                                                    @"ID":@"12",
                                                    },
                                                ]
                                        
                                        },
                                    @{
                                        @"headID":@"11",
                                        @"headState":@1,
                                        @"discount":@"9",
                                        @"headCellArray":@[
                                                @{
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@2,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@1,
                                                    @"ID":@"13",
                                                    },
                                                @{
                                                    
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@2,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@0,
                                                    @"ID":@"14",
                                                    },
                                                ]
                                        
                                        },
                                    @{
                                        @"headID":@"10",
                                        @"headState":@0,
                                        @"discount":@"9",
                                        @"headCellArray":@[
                                                @{
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@2,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@0,
                                                    @"ID":@"15",
                                                    },
                                                
                                                ]
                                        
                                        },
                                    @{
                                        @"headID":@"10",
                                        @"headState":@0,
                                        @"discount":@"9",
                                        @"headCellArray":@[
                                                @{
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@2,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@0,
                                                    @"ID":@"16",
                                                    },
                                                
                                                ]
                                        
                                        },
                                    
                                    
                                    ]
                            };
    
    
    NSMutableArray *arrayl = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in dicts[@"item"]) {
        
        NSMutableArray *dictarray = [[NSMutableArray alloc] init];
        DCShoppingModel *model = [[DCShoppingModel alloc] initWithShopDict:dict];
        [dictarray addObject:model];
        
        [arrayl addObject:model];
        
    }
    
    shopping.shoppingArray = arrayl;
    
}

#pragma mark 编辑
-(void)editBtn
{
    if (editbool) {
        
        [shopping editBtn:editbool];
        editbool = NO;
    }else{
        
        
        [shopping editBtn:editbool];
        editbool = YES;
    }
    
    [_editLabel setTitle:editbool?@"完成":@"编辑" forState:UIControlStateNormal];
    [self setTlementLabel];
    _allPriceLabel.hidden = editbool;
    
}

#pragma mark 返回
-(void)returnBtnDidClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma 全选
-(void)allBtnDidClick
{
    [shopping allBtn:!isbool];
}
#pragma mark 全选
-(void)setAllBtnState:(BOOL)_bool{
    
    if (_bool) {
        
        _allImage.image = [UIImage imageNamed:@"iconfont-yuanquan"];
        isbool = NO;
        
    }else{
        
        _allImage.image = [UIImage imageNamed:@"iconfont-zhengque"];
        isbool = YES;
    }
}

#pragma mark 结算
-(void)settlementBtnDidClick
{
    if (editbool) {
        
        [shopping deleteBtn:editbool];
        
    }else{
        
        
        NSLog(@"结算:%@",cellArray);
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

@end
