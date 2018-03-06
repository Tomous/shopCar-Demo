//
//  DCShoppingTableView.h
//  类似QQ主页的侧滑
//
//  Created by 许大成 on 17/5/31.
//  Copyright © 2017年 许大成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCShoppingTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *shoppingArray;

-(void)allBtn:(BOOL)isbool;

-(void)editBtn:(BOOL)isbool;

-(void)deleteBtn:(BOOL)isbool;

@end
