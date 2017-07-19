//
//  NewViewController.m
//  Ground
//
//  Created by cici on 2017/6/28.
//  Copyright © 2017年 keke. All rights reserved.
//

#import "NewViewController.h"
#import "CustomView.h"
#define time 6.0
#define  bicycleHeight  9.0 //自动车一半的高度
@interface NewViewController (){
    
    UIImageView* circleView1 ;
    CGFloat  angle;
    NSTimer* timer ;
    CGFloat timeNum;
    CustomView *customView;
    UIView*line;
    UIView*line1;
}

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 300, 100, 20)];
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];
    [btn setTitle:@"沿轨迹运动" forState:0];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnClick:(UIButton*)sender{
    
    [circleView1 removeFromSuperview];
    [customView removeFromSuperview];
    [line1 removeFromSuperview];
    [line removeFromSuperview];
    timer.fireDate = [NSDate distantFuture];
    [timer invalidate];
    
    angle=M_PI/2;
    timeNum=0.00;
    
    //路径是一个圆和两个直线（两条直线串联 不交）
    customView = [[CustomView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 80, 100, 100)];
    [self.view addSubview:customView];
    
    line=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50-20, 80+100-3, 70, 3)];
    line.backgroundColor=[UIColor colorWithRed:1 green:140/255.0 blue:0 alpha:1];
    [self.view addSubview:line];
    
    line1=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 80+100-3, 70, 3)];
    line1.backgroundColor=[UIColor colorWithRed:1 green:140/255.0 blue:0 alpha:1];
    [self.view addSubview:line1];
    
    //自行车的运动
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = time;
    pathAnimation.repeatCount = 1;
    
    //设置运转动画的路径
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    //将路径的起点定位到
    //第一段直线路径
    CGPathMoveToPoint(curvedPath,NULL,self.view.frame.size.width/2-50-20, 80+100-3-bicycleHeight);
    CGPathAddLineToPoint(curvedPath, NULL, self.view.frame.size.width/2, 80+100-3-bicycleHeight);
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(transform) userInfo:nil repeats:YES];
    //曲线路径
    CGPathAddArc(curvedPath, NULL, self.view.frame.size.width/2, 80+50, 50-3-bicycleHeight, M_PI/2,(M_PI+0.01)/2, 1);//1为逆时针 当开始角度与结束角度相同时 他就会沿直线走 ，因为是逆时针 所以以最低端M_PI/2开始
    
    //第二段直线路径
    CGPathMoveToPoint(curvedPath,NULL,self.view.frame.size.width/2, 80+100-3-bicycleHeight);
    CGPathAddLineToPoint(curvedPath, NULL, self.view.frame.size.width/2+70-8, 80+100-3-bicycleHeight);//此处的8 是让轮子不掉下去
    
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    circleView1 = [[UIImageView alloc] init];
    circleView1.frame = CGRectMake(0, 0, 22, 22);
    [self.view addSubview:circleView1];
    circleView1.image=[UIImage imageNamed:@"act_ic1_n"];
    [circleView1.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
    
}
- (void)transform{
    timeNum=timeNum+0.01;
    //大致  时间速度
    if (timeNum<0.01*5.2*100&&timeNum>0.01*1*100) {
        
        angle = angle +2*M_PI/420;
        circleView1.transform = CGAffineTransformMakeRotation(-angle+M_PI/2);
    }else{
        return;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
