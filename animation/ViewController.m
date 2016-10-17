//
//  ViewController.m
//  animation
//
//  Created by Jiafei on 16/9/2.
//  Copyright © 2016年 com.wahool. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView  *imgPic;


@end

@implementation ViewController
{
    BOOL            _bl;//
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _bl = YES;
    //
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    //
    _imgPic = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _imgPic.contentMode = UIViewContentModeScaleAspectFit;
    _imgPic.image = [UIImage imageNamed:@"1.jpg"];
    //
    [self.view addSubview:_imgPic];
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (_bl) {
        _imgPic.image = [UIImage imageNamed:@"2.jpg"];
    }else{
        _imgPic.image = [UIImage imageNamed:@"1.jpg"];
    }
    
    //贝塞尔曲线路径
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:CGPointMake(0.0, 0.0)];
    [movePath addQuadCurveToPoint:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0) controlPoint:CGPointMake(self.view.frame.size.width, self.view.frame.size.height)];
    
    //以下必须导入QuartzCore包
    //关键帧动画（位置）
    CAKeyframeAnimation * posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = movePath.CGPath;
    posAnim.removedOnCompletion = YES;
    
    //缩放动画
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.removedOnCompletion = YES;
    
    //透明动画
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    //动画组
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:posAnim, opacityAnim, scaleAnim, nil];
    animGroup.duration = 1;
    //
    [_imgPic.layer addAnimation:animGroup forKey:nil];
    
    _bl = !_bl;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
