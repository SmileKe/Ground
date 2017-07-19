//
//  CustomView.m
//  Ground
//
//  Created by cici on 2017/6/28.
//  Copyright © 2017年 keke. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor  clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect  {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,1,140/255.0,0,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 3.0);//线的宽度
    
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, self.frame.size.width/2-3, 0, 2*M_PI, 1); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
}


@end
