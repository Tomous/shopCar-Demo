//
//  DCShoppingTableViewCell.h
//  类似QQ主页的侧滑
//
//  Created by 许大成 on 17/5/31.
//  Copyright © 2017年 许大成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCShoppingModel.h"
#import "DCShoppingBtn.h"

@protocol AddNumViewDelegate <NSObject>

-(void)AddNumView:(NSInteger)num;

@end

@interface DCAddNumView : UIView

{
    
    UIButton *minusBtn;
    UIButton *addBtn;
    UILabel *numLabel;
    NSInteger num;
}

@property (nonatomic, weak) id<AddNumViewDelegate>delegate;

@property (nonatomic, assign) NSInteger numInteger;

@property (nonatomic, assign) NSInteger minInteget;

@end




@protocol EditCartViewDelegate <NSObject>

-(void)EditCartView:(NSInteger)num;

-(void)EditCartView;

@end

@interface DCEditCartView : UIView

@property (nonatomic, weak) id<EditCartViewDelegate>delegate;

@property(nonatomic, assign) NSInteger numInteger;

@property(nonatomic, strong) NSString *styleString;

@property(nonatomic, assign) NSInteger maxInteger;

@property (nonatomic, assign) NSInteger minInteget;

@end





@protocol ShoppingTableViewCellDelegate <NSObject>

-(void)ShoppingTableViewCell:(ShoppingCellModel *)model;

@end

@interface DCShoppingTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ShoppingTableViewCellDelegate>delegate;

@property (nonatomic, strong) ShoppingCellModel *model;

@end
