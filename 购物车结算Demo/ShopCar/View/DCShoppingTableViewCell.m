//
//  DCShoppingTableViewCell.m
//  类似QQ主页的侧滑
//
//  Created by 许大成 on 17/5/31.
//  Copyright © 2017年 许大成. All rights reserved.
//

#import "DCShoppingTableViewCell.h"
#import "Util.h"
#import "Header.h"

@implementation DCAddNumView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        num = 1;
        self.backgroundColor = UIColorRGBA(251, 251, 251, 1);
        [Util makeCorner:0.5 view:self color:GrayLine];
        
        minusBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, frame.size.height)];
        [minusBtn setTitle:@"-" forState:UIControlStateNormal];
        [minusBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        minusBtn.titleLabel.font = [UIFont systemFontOfSize:37.0];
        [minusBtn addTarget:self action:@selector(MinusBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:minusBtn];
        
        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, (frame.size.height - 18)/2, 35, 18)];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.textColor = TextColor;
        numLabel.font = [UIFont systemFontOfSize:17.0];
        [self addSubview:numLabel];
        [Util setFoursides:numLabel Direction:@"left" sizeW:18];
        [Util setFoursides:numLabel Direction:@"right" sizeW:18];
        
        addBtn = [[UIButton alloc] initWithFrame:CGRectMake(64, 0, 32, frame.size.height)];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setTitleColor:UIColorRGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:25.0];
        [addBtn addTarget:self action:@selector(AddBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:addBtn];
        
    }
    return self;
}

-(void)MinusBtn:(UIButton *)sender{
    
    if ((num - 1) <= 0 || num == 0) {
        
        NSLog(@"超出范围");
        
    }else{
        
        num  = num -1;
    }
    
    numLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    
    [_delegate AddNumView:num];
}

-(void)AddBtn:(UIButton *)sender{
    
    if (num >= 10 ) {
        
        NSLog(@"超出范围");
        
    }else{
        
        num = num +1;
    }
    
    numLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    
    [_delegate AddNumView:num];
    
}

-(void)setNumInteger:(NSInteger)numInteger{
    
    _numInteger = numInteger;
    numLabel.text = [NSString stringWithFormat:@"%ld",(long)_numInteger];
    num = _numInteger;
}

-(void)setMinInteget:(NSInteger)minInteget{
    
    _minInteget = minInteget;
    if (_minInteget == 0) {
        
        [_delegate AddNumView:_minInteget];
        numLabel.text = @"0";
        num = 0;
        
    }else if (_minInteget<=[numLabel.text integerValue]){
        
        [_delegate AddNumView:_minInteget];
        numLabel.text = [NSString stringWithFormat:@"%ld",(long)_minInteget];
        num = _minInteget;
    }
    
}
@end


@implementation DCEditCartView
{
    NSInteger num;
    
    UIView *topView;
    UIButton *minusBtn;
    UILabel *numLabel;
    UIButton *addBtn;
    
    UIView *bottomView;
    UILabel *styleLabel;
    UIImageView *imageView;
    
}
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        num = 1;
        topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
        topView.backgroundColor = UIColorRGBA(251, 251, 251, 1);
        [self addSubview:topView];
        
        minusBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, topView.frame.size.height +5, topView.frame.size.height)];
        [minusBtn setTitle:@"-" forState:UIControlStateNormal];
        [minusBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        minusBtn.titleLabel.font = [UIFont systemFontOfSize:37.0];
        [minusBtn addTarget:self action:@selector(MinusBtn:) forControlEvents:UIControlEventTouchDown];
        [topView addSubview:minusBtn];
        
        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(topView.frame.size.height +5, (topView.frame.size.height - 18)/2,topView.frame.size.width - (topView.frame.size.height +5) *2, 18)];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.textColor = TextColor;
        numLabel.font = [UIFont systemFontOfSize:17.0];
        [topView addSubview:numLabel];
        [Util setFoursides:numLabel Direction:@"left" sizeW:18];
        [Util setFoursides:numLabel Direction:@"right" sizeW:18];
        
        addBtn = [[UIButton alloc] initWithFrame:CGRectMake([Util ReturnViewFrame:numLabel Direction:@"X"], 0, topView.frame.size.height +5, topView.frame.size.height)];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setTitleColor:UIColorRGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:25.0];
        [addBtn addTarget:self action:@selector(AddBtn:) forControlEvents:UIControlEventTouchDown];
        [topView addSubview:addBtn];
        
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height/2, frame.size.width, frame.size.height/2)];
        bottomView.backgroundColor = [UIColor whiteColor];
        [Util setFoursides:bottomView Direction:@"top" sizeW:frame.size.width];
        [self addSubview:bottomView];
        [Util addClickEvent:self action:@selector(bottom) owner:bottomView];
        
        
        styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, bottomView.frame.size.width - 15 - 30, frame.size.height/2)];
        styleLabel.textColor = UIColorRGBA(102, 102, 102, 1);
        styleLabel.font = [UIFont systemFontOfSize:13.0];
        [bottomView addSubview:styleLabel];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake([Util ReturnViewFrame:styleLabel Direction:@"X"] + 3, frame.size.height/4- 7.5, 15, 15)];
        imageView.image = [UIImage imageNamed:@"down.png"];
        [bottomView addSubview:imageView];
        
    }
    return self;
}
-(void)MinusBtn:(UIButton *)sender{
    
    if ((num - 1) <= 0 || num == 0) {
        
        NSLog(@"超出范围");
        
    }else{
        
        num  = num -1;
    }
    
    numLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    [_delegate EditCartView:num];
    
}

-(void)AddBtn:(UIButton *)sender{
    
    if (num >= 10 ) {
        
        NSLog(@"超出范围");
        
    }else{
        
        num = num +1;
    }
    
    numLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    [_delegate EditCartView:num];
}
-(void)bottom{
    
    [_delegate EditCartView];
}
-(void)setNumInteger:(NSInteger)numInteger{
    
    _numInteger = numInteger;
    numLabel.text = [NSString stringWithFormat:@"%ld",(long)_numInteger];
    num = _numInteger;
}
-(void)setStyleString:(NSString *)styleString{
    
    styleLabel.text = styleString;
}

-(void)setMinInteget:(NSInteger)minInteget{
    
    _minInteget = minInteget;
    if (_minInteget == 0) {
        
        [_delegate EditCartView:_minInteget];
        numLabel.text = @"0";
        num = 0;
        
    }else if (_minInteget<=[numLabel.text integerValue]){
        
        [_delegate EditCartView:_minInteget];
        numLabel.text = [NSString stringWithFormat:@"%ld",(long)_minInteget];
        num = _minInteget;
    }
    
}
@end




@interface DCShoppingTableViewCell ()<AddNumViewDelegate,EditCartViewDelegate>

@end
@implementation DCShoppingTableViewCell
{
    
    NSIndexPath *indexPath;
    
    //图片
    UIImageView *headImageView;
    
    //标题
    UILabel *titleLabel;
    
    //价格
    UILabel *priceLabel;
    
    //颜色&尺码
    UILabel *styleLabel;
    
    DCEditCartView *editcartView;
    
    DCAddNumView *addnumView;
    
    //确定
    DCShoppingBtn *okBtn;
    
    UILabel *mustLabel;
    
    BOOL isbool;
    
}
- (void)awakeFromNib {
    
}



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //勾选按钮
        okBtn = [[DCShoppingBtn alloc] initWithFrame:CGRectMake(0, 0, 55, 100)];
        [okBtn addTarget:self action:@selector(OKBtn:) forControlEvents:UIControlEventTouchDown];
        
        
        //图片
        headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 15, 70, 70)];
        headImageView.backgroundColor = [UIColor whiteColor];
        
        mustLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 67, 70, 18)];
        mustLabel.textColor = [UIColor whiteColor];
        mustLabel.text = @"必选单品";
        mustLabel.backgroundColor = UIColorRGBA(239, 34, 109, 0.6);
        mustLabel.textAlignment = NSTextAlignmentCenter;
        mustLabel.font = [UIFont systemFontOfSize:12.0];
        mustLabel.hidden = YES;
        
        
        //标题
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake([Util ReturnViewFrame:headImageView Direction:@"X"] +10, 15, SCREEN_WIDTH - ([Util ReturnViewFrame:headImageView Direction:@"X"] +91), 18)];
        titleLabel.textColor = TextColor;
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        //颜色 尺码
        styleLabel = [[UILabel alloc] initWithFrame:CGRectMake([Util ReturnViewFrame:headImageView Direction:@"X"] +10, [Util ReturnViewFrame:titleLabel Direction:@"Y"], SCREEN_WIDTH-[Util ReturnViewFrame:headImageView Direction:@"X"] - 20, 18)];
        styleLabel.textColor = [UIColor grayColor];
        styleLabel.font = [UIFont systemFontOfSize:12.0];
        
        //价格
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 15, 70, 18)];
        priceLabel.textColor = TextColor;
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.font = [UIFont systemFontOfSize:12.0];
        
        
        addnumView = [[DCAddNumView alloc] initWithFrame:CGRectMake([Util ReturnViewFrame:headImageView Direction:@"X"] +10, [Util ReturnViewFrame:headImageView Direction:@"Y"] - 30, 100, 30)];
        addnumView.delegate = self;
        [self addSubview:addnumView];
        
        [self addSubview:okBtn];
        [self addSubview:headImageView];
        [self addSubview:mustLabel];
        [self addSubview:titleLabel];
        [self addSubview:styleLabel];
        [self addSubview:priceLabel];
        
        
        
        editcartView = [[DCEditCartView alloc ] initWithFrame:CGRectMake([Util ReturnViewFrame:headImageView Direction:@"X"] +10, 15, SCREEN_WIDTH - ([Util ReturnViewFrame:headImageView Direction:@"X"] +20) , 70)];
        editcartView.delegate = self;
        editcartView.backgroundColor = [UIColor orangeColor];
        [Util makeCorner:2 view:editcartView];
        [Util makeCorner:0.5 view:editcartView color:GrayLine];
        [self addSubview:editcartView];
        editcartView.hidden = YES;
        
        
        
    }
    
    return  self;
}


-(void)setModel:(ShoppingCellModel *)model{
    
    _model = model;
    
    indexPath = [NSIndexPath indexPathForRow:model.row inSection:model.section];
    
    headImageView.image = [UIImage imageNamed:_model.imageUrl];
    titleLabel.text = model.title;
    styleLabel.text = [NSString stringWithFormat:@"颜色: %@   尺码: %@",model.color,model.size];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    mustLabel.hidden = model.mustInteger == 0?YES:NO;
    addnumView.numInteger = model.numInt;
    editcartView.numInteger = model.numInt;
    editcartView.styleString = styleLabel.text;
    
    if (model.cellClickState == 1) {
        
        isbool = YES;
        [okBtn setImage:[UIImage imageNamed:@"iconfont-zhengque"] forState:UIControlStateNormal];
        
    } else {
        
        isbool = NO;
        [okBtn setImage:[UIImage imageNamed:@"iconfont-yuanquan"] forState:UIControlStateNormal];
    }
    
    if (model.cellEditState ==1) {
        
        editcartView.hidden = NO;
        
    }else{
        
        editcartView.hidden = YES;
        
    }
    
}

-(void)EditCartView:(NSInteger)num{
    
    _model.numInt = num;
    [_delegate ShoppingTableViewCell:_model];
}

-(void)EditCartView{
    
}

-(void)AddNumView:(NSInteger)num{
    
    _model.numInt = num;
    [_delegate ShoppingTableViewCell:_model];
}

-(void)OKBtn:(UIButton *)sendel{
    
    if (isbool) {
        
        _model.cellClickState = 0;
        [_delegate ShoppingTableViewCell:_model];
        [okBtn setImage:[UIImage imageNamed:@"iconfont-yuanquan"] forState:UIControlStateNormal];
        isbool = NO;
        
    }else{
        
        _model.cellClickState = 1;
        [_delegate ShoppingTableViewCell:_model ];
        [okBtn setImage:[UIImage imageNamed:@"iconfont-zhengque"] forState:UIControlStateNormal];
        isbool = YES;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}


@end
