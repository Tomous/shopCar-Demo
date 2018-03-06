//
//  DCShoppingModel.m
//  类似QQ主页的侧滑
//
//  Created by 许大成 on 17/5/31.
//  Copyright © 2017年 许大成. All rights reserved.
//

#import "DCShoppingModel.h"

@implementation DCShoppingModel

@synthesize headClickState;

@synthesize headPriceDict;

-(instancetype)initWithShopDict:(NSDictionary *)dict{
    
    self.headID = dict[@"headID"];
    
    self.headState = [dict[@"headState"] integerValue];
    
    self.discount  = dict[@"discount"];
    
    self.headCellArray = [NSMutableArray arrayWithArray:[self ReturnData:dict[@"headCellArray"]]];
    
    self.headClickState = 0;
    
    self.headPriceDict = [[NSDictionary alloc] init];
    self.headPriceDict = @{
                           @"headTitle":[NSString stringWithFormat:@"选择必选单品,即可享受%@折优惠",self.discount],
                           @"footerTitle":@"小计:¥0.00",
                           @"footerMinus":@""
                           };
    
    return self ;
}

-(NSArray *)ReturnData:(NSArray *)array{
    
    NSMutableArray *arrays= [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        
        ShoppingCellModel *model = [[ShoppingCellModel alloc] initWithShopDict:dict];
        [arrays addObject:model];
        
    }
    
    return arrays;
}

@end

@implementation ShoppingCellModel

@synthesize row;
@synthesize section;
@synthesize indexState;
@synthesize cellClickState;
@synthesize cellPriceDict;
@synthesize cellEditState;
-(instancetype)initWithShopDict:(NSDictionary *)dict{
    
    self.ID = dict[@"ID"];
    self.imageUrl = dict[@"imageUrl"];
    self.title = dict[@"title"];
    self.color = dict[@"color"];
    self.size = dict[@"size"];
    self.price =dict[@"price"];
    self.mustInteger = [dict[@"mustInteger"] integerValue];
    self.numInt = [dict[@"numInt"] integerValue];
    self.inventoryInt = [dict[@"inventoryInt"] integerValue];
    self.discountNum = dict[@"discountNum"];
    self.row = 0;
    self.section = 0;
    self.indexState = 0;
    self.cellClickState = 0;
    self.cellEditState = 0;
    self.cellPriceDict = [[NSDictionary alloc] init];
    return self ;
}

@end
