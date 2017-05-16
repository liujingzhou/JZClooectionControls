//
//  JZViscosityBtn.m
//  JZClooectionControls
//
//  Created by tcyx on 2017/5/11.
//  Copyright © 2017年 ljz. All rights reserved.
//

#import "JZViscosityBtn.h"

@interface JZViscosityBtn()

/** 拉开后显示的小圆 */
@property (nonatomic, strong) UIView *smallCircle;

/** 形状图层 */
@property (nonatomic, weak) CAShapeLayer *shapLayer;
@end


@implementation JZViscosityBtn

#pragma mark - init methods
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp {
    self.smallCircle.backgroundColor = self.backGroundColor;

    [self setBackgroundColor:[UIColor blueColor]];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    self.smallCircle = [[UIView alloc] init];
    [newSuperview insertSubview:self.smallCircle belowSubview:self];
}

- (void)layoutSubviews {
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    self.smallCircle.layer.cornerRadius = self.layer.cornerRadius;
    self.smallCircle.frame = self.frame;
}

//disabale Highlighted
- (void)setHighlighted:(BOOL)highlighted {
    
}

#pragma mark - setter and getter
- (CAShapeLayer *)shapLayer {
    if (_shapLayer == nil) {
        CAShapeLayer *shapLayer = [CAShapeLayer layer];
        [self.superview.layer insertSublayer:shapLayer atIndex:0];
        shapLayer.fillColor = self.backGroundColor.CGColor;
        _shapLayer = shapLayer;
    }
    return _shapLayer;
}

- (void)setBackGroundColor:(UIColor *)backGroundColor {
    _backGroundColor = backGroundColor;
    
    _smallCircle.backgroundColor = backGroundColor;
    self.backgroundColor = backGroundColor;
}

- (NSTimeInterval)animationDurationTime {
    return _animationDurationTime ? _animationDurationTime : 1;
}

#pragma mark - GestureRecognizer method

/**
 拖动手势
 */
- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint transP = [pan translationInView:self];
    
    CGPoint center = self.center;
    center.x += transP.x;
    center.y += transP.y;
    self.center = center;
    
    //重置
    [pan setTranslation:CGPointZero inView:self];

    CGFloat distance = [self distanceWithSmallCircle:self.smallCircle BigCirCle:self];
    MSLog(@"%f",distance);
    //让小圆半径根据距离的增大,半径在减小
    CGFloat smallR = self.bounds.size.width * 0.5;
    smallR -= distance / 10.0;
    self.smallCircle.bounds = CGRectMake(0, 0, smallR * 2, smallR * 2);
    self.smallCircle.layer.cornerRadius = smallR;
    
    
    UIBezierPath *path = [self pathWithSmallCircle:self.smallCircle BigCirCle:self];
    
    // 形状图层
    if (self.smallCircle.hidden == NO) {
        self.shapLayer.path = path.CGPath;
    }

    if (distance > 60) { //让小圆隐藏,让路径小时
        self.smallCircle.hidden = YES;
        [self.shapLayer removeFromSuperlayer];
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) { //判断距离是否需要复位.
        if(distance < 60) { //复位
            [self.shapLayer removeFromSuperlayer];
            self.smallCircle.hidden = NO;
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.center = self.smallCircle.center;
            } completion:nil];
            
        }else { //播放一个动画消失
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
            [self addSubview:imageV];
            
            imageV.animationImages = _animationImageArray;
            imageV.animationDuration = _animationDurationTime;
            [imageV startAnimating];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_animationDurationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
        }
    }
}

#pragma mark - tool methods
/**
 给定两个圆,描述一个不规则的路径

 @param smallCircle 圆1
 @param bigCircle 圆2
 @return 计算出来的路径
 */
- (UIBezierPath *)pathWithSmallCircle:(UIView *)smallCircle BigCirCle:(UIView  *)bigCircle {
    
    
    CGFloat x1 = smallCircle.center.x;
    CGFloat y1 = smallCircle.center.y;
    
    CGFloat x2 = bigCircle.center.x;
    CGFloat y2 = bigCircle.center.y;
    
    CGFloat d = [self distanceWithSmallCircle:smallCircle BigCirCle:bigCircle];
    
    if (d <= 0) {
        return nil;
    }
    
    
    CGFloat cosθ = (y2 - y1) / d;
    CGFloat sinθ = (x2 - x1) / d;
    
    CGFloat r1 = smallCircle.bounds.size.width * 0.5;
    CGFloat r2 = bigCircle.bounds.size.width * 0.5;
    
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ, y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d * 0.5 * sinθ, pointA.y + d * 0.5 * cosθ);
    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 * sinθ, pointB.y + d * 0.5 * cosθ);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    //BC(曲线)
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    //CD
    [path addLineToPoint:pointD];
    //DA(曲线)
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
    
}

/**
 求两个圆之间距离（根据center计算）

 @param smallCircle 圆1
 @param bigCircle 圆2
 @return 距离
 */
- (CGFloat)distanceWithSmallCircle:(UIView *)smallCircle BigCirCle:(UIView  *)bigCircle {
    CGFloat offsetX = bigCircle.center.x - smallCircle.center.x;
    CGFloat offsetY = bigCircle.center.y - smallCircle.center.y;
    
    return  sqrt(offsetX * offsetX + offsetY * offsetY);
}

@end
