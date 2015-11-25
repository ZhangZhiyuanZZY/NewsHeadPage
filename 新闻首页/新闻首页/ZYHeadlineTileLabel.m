//
//  ZYHeadlineTileLabel.m
//  新闻首页
//
//  Created by 章芝源 on 15/11/22.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ZYHeadlineTileLabel.h"

@implementation ZYHeadlineTileLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:25];
        self.scale = 0.0;  //这里使用set方法, 一次就  一进来就把文字大小颜色设置好
    }
    return self;
}



- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    //设置颜色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    
   
    
    CGFloat minScale = 0.6;
    
    CGFloat lastScale = minScale + (1 - minScale) * scale;
    
    //设置大小
    self.transform = CGAffineTransformMakeScale(lastScale, lastScale);

}

@end
