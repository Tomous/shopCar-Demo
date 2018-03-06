//
//  DCShoppingBtn.m
//  类似QQ主页的侧滑
//
//  Created by 许大成 on 17/5/31.
//  Copyright © 2017年 许大成. All rights reserved.
//

#import "DCShoppingBtn.h"

@implementation DCShoppingBtn

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    
    if (self) {
        
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        
    }
    return self;
}



#pragma mark 根据父类的rect设定并返回文本label的rect
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat titleW=0;
    CGFloat titleH=0;
    CGFloat titleX=0;
    CGFloat titleY=0;
    
    contentRect=(CGRect){{titleX,titleY},{titleW,titleH}};
    return contentRect;
}

#pragma  mark根据父类的rect设定并返回Image的rect
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW=25;
    CGFloat imageH=25;
    CGFloat imageX=(self.frame.size.width - 25)*0.5;
    CGFloat imageY=(self.frame.size.height - 25)*0.5;
    
    contentRect=(CGRect){{imageX,imageY},{imageW,imageH}};
    return contentRect;
}

@end
