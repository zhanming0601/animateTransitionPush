//
//  SecondViewController.m
//  animateTransition
//
//  Created by zhanming on 16/6/1.
//  Copyright © 2016年 zhanming. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomAnimateTransitionPop.h"

@interface SecondViewController ()
@property(nonatomic,strong)UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation SecondViewController


//-(UIPercentDrivenInteractiveTransition *)interactiveTransition
//{
//    if(_interactiveTransition==nil)
//    {
//        _interactiveTransition=[UIPercentDrivenInteractiveTransition new];
//    }
//    
//    return _interactiveTransition;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    UIImageView * secondImage=[[UIImageView alloc]initWithImage:self.myImage];
    
    secondImage.frame=self.view.bounds;
    
    [self.view addSubview:secondImage];
    
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:gestureRecognizer];

    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.delegate=self;
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    
    /*调用UIPercentDrivenInteractiveTransition的updateInteractiveTransition:方法可以控制转场动画进行到哪了，
      当用户的下拉手势完成时，调用finishInteractiveTransition或者cancelInteractiveTransition，UIKit会自动执行剩下的一半动画，
      或者让动画回到最开始的状态。*/
    
  
    
    if([gestureRecognizer translationInView:self.view].x>=0)
    {
        //手势滑动的比例
        CGFloat per = [gestureRecognizer translationInView:self.view].x / (self.view.bounds.size.width);
        per = MIN(1.0,(MAX(0.0, per)));
        
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            
            self.interactiveTransition=[UIPercentDrivenInteractiveTransition new];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
            
            [ self.interactiveTransition updateInteractiveTransition:per];
            
        }else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled){
            if (per > 0.5) {
                [ self.interactiveTransition finishInteractiveTransition];
            }else{
                [ self.interactiveTransition cancelInteractiveTransition];
            }
             self.interactiveTransition = nil;
        }
        
        
    }
}

//为这个动画添加用户交互
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return self.interactiveTransition;
}
//用来自定义转场动画
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        CustomAnimateTransitionPop *pingInvert = [CustomAnimateTransitionPop new];
        return pingInvert;
    }else{
        return nil;
    }
}



@end
