//
//  ViewController.m
//  animateTransition
//
//  Created by 战明 on 16/5/26.
//  Copyright © 2016年 zhanming. All rights reserved.
//

#import "ViewController.h"
#import "CustomAnimateTransitionPush.h"

#import "SecondViewController.h"
@interface ViewController ()<UINavigationControllerDelegate>

@property(strong,nonatomic)NSArray <UIButton*> *arrayBtn;
@property(strong,nonatomic)UIButton *btnA;
@property(strong,nonatomic)UIButton *btnB;
@property(strong,nonatomic)UIButton *btnC;
@property(strong,nonatomic)UIButton *btnD;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor=[UIColor colorWithRed:0.98f green:0.97f blue:0.90f alpha:1.00f];
    self.title=@"自定义转场动画";
    
    //设置button
    [self setButton];

}


//用来自定义转场动画
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    if(operation==UINavigationControllerOperationPush)
    {
        CustomAnimateTransitionPush *animateTransitionPush=[CustomAnimateTransitionPush new];
        return animateTransitionPush;
    }
    else
    {
        return nil;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 必须在viewDidAppear或者viewWillAppear中写，因为每次都需要将delegate设为当前界面
    self.navigationController.delegate=self;
    
    [self setBtnAnimation];
    
}

-(void)btnclick:(UIButton *)btn
{
    self.button=btn;
    
    
    
    
    SecondViewController *push=[SecondViewController new];
    
    if(btn == self.btnA)
    {
        push.myImage=[UIImage imageNamed:@"IMG_1"];
        
    }else if(btn == self.btnB)
    {
        push.myImage=[UIImage imageNamed:@"IMG_2"];
        
    }else if(btn == self.btnC)
    {
        push.myImage=[UIImage imageNamed:@"IMG_3"];
        
    }else if(btn == self.btnD)
    {
        push.myImage=[UIImage imageNamed:@"IMG_4"];
    }

    
    [self.navigationController pushViewController:push animated:YES];
}

-(void)setButton
{
    CGFloat margin=50;
    
    CGFloat width=(self.view.frame.size.width-margin*3)/2;
    
    CGFloat height =width;
    
    UIButton *btnA=[UIButton buttonWithType:UIButtonTypeCustom];
    
    btnA.frame=CGRectMake(margin,150,width,height);
    [btnA addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    btnA.backgroundColor=[UIColor colorWithRed:0.67f green:0.87f blue:0.92f alpha:1.00f];
    
    btnA.layer.cornerRadius=width/2;
    
    [self.view addSubview:btnA];
    self.btnA=btnA;
    
    UIButton *btnB=[UIButton buttonWithType:UIButtonTypeCustom];
    btnB.layer.cornerRadius=width/2;
    btnB.frame=CGRectMake(CGRectGetMaxX(btnA.frame)+margin,CGRectGetMinY(btnA.frame),width,height);
    [btnB addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    btnB.backgroundColor=[UIColor colorWithRed:0.96f green:0.76f blue:0.78f alpha:1.00f];
    [self.view addSubview:btnB];
    self.btnB=btnB;
    
    UIButton *btnC=[UIButton buttonWithType:UIButtonTypeCustom];
    btnC.layer.cornerRadius=width/2;
    btnC.frame=CGRectMake(CGRectGetMinX(btnA.frame),CGRectGetMaxY(btnA.frame)+margin,width,height);
    [btnC addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    btnC.backgroundColor=[UIColor colorWithRed:0.99f green:0.89f blue:0.49f alpha:1.00f];
    [self.view addSubview:btnC];
    self.btnC=btnC;
    
    UIButton *btnD=[UIButton buttonWithType:UIButtonTypeCustom];
    btnD.layer.cornerRadius=width/2;
    btnD.frame=CGRectMake(CGRectGetMaxX(btnC.frame)+margin,CGRectGetMinY(btnC.frame),width,height);
    [btnD addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    btnD.backgroundColor=[UIColor colorWithRed:0.53f green:0.82f blue:0.93f alpha:1.00f];
    [self.view addSubview:btnD];
    self.btnD=btnD;
    
    
    
    self.arrayBtn=@[btnA,btnB,btnC,btnD];

}

#pragma -mark 这里的动画只使用了CoreAnimation，使用简单的代码实现了button的浮动，给大家一个思路，没有封装代码也比较垃圾，请见谅

-(void)setBtnAnimation
{
 
    for (UIButton *btn in self.arrayBtn) {
        
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
      
        pathAnimation.repeatCount = MAXFLOAT;
        pathAnimation.autoreverses=YES;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        
        if(btn == self.btnA)
        {
           pathAnimation.duration=5;
            
        }else if(btn == self.btnB)
        {
           pathAnimation.duration=6;
            
        }else if(btn == self.btnC)
        {
          pathAnimation.duration=7;
            
        }else if(btn == self.btnD)
        {
          pathAnimation.duration=4;
        }
        
        
        UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectInset(btn.frame, btn.frame.size.width/2-5, btn.frame.size.width/2-5)];
        
        pathAnimation.path=path.CGPath;
        
        [btn.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
        
        
        

        
        CAKeyframeAnimation *scaleX=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
        
        scaleX.values   = @[@1.0, @1.1, @1.0];
        scaleX.keyTimes = @[@0.0, @0.5,@1.0];
        scaleX.repeatCount = MAXFLOAT;
        scaleX.autoreverses = YES;
      
        
        if(btn == self.btnA)
        {
            scaleX.duration=4;
            
        }else if(btn == self.btnB)
        {
            scaleX.duration=5;
            
        }else if(btn == self.btnC)
        {
            scaleX.duration=7;
            
        }else if(btn == self.btnD)
        {
            scaleX.duration=6;
        }

        [btn.layer addAnimation:scaleX forKey:@"scaleX"];
        
        
        CAKeyframeAnimation *scaleY=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
        
        scaleY.values   = @[@1.0, @1.1, @1.0];
        scaleY.keyTimes = @[@0.0, @0.5,@1.0];
        scaleY.repeatCount = MAXFLOAT;
        scaleY.autoreverses = YES;
        if(btn == self.btnA)
        {
            scaleY.duration=6;
            
        }else if(btn == self.btnB)
        {
            scaleY.duration=7;
            
        }else if(btn == self.btnC)
        {
            scaleY.duration=4;
            
        }else if(btn == self.btnD)
        {
            scaleY.duration=5;
        }

        [btn.layer addAnimation:scaleY forKey:@"scaleY"];

        
        
    }
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
