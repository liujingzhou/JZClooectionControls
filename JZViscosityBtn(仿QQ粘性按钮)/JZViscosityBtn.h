//
//  JZViscosityBtn.h
//  JZClooectionControls
//
//  Created by tcyx on 2017/5/11.
//  Copyright © 2017年 ljz. All rights reserved.
//

/**
 支持xib创建及代码创建
 使用注意：1.使用时请设置默认图片和选中图片,否则将显示空白
 2.设置代理以接收返回密码值
 3.请注意查看tag值和其它view的tag值是否有冲突
 4.根据需求设置自定义属性
 */

#import <UIKit/UIKit.h>

@interface JZViscosityBtn : UIButton
/**粘性按钮消失的动画数组（请设置）*/
@property(nonatomic, strong) NSArray *animationImageArray;


/**背景颜色（默认blueColor）*/
@property(nonatomic, strong) UIColor *backGroundColor;

/**消失动画持续时间（默认1s）*/
@property(nonatomic, assign) NSTimeInterval animationDurationTime;
@end
