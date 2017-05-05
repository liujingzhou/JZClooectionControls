## JZClooectionControls

* 一套平时开发用到的iOS控件集合的归类，方便快速开发以下功能

## Contents
### 1.手势解锁

* 在使用到的地方#import "JZGestureUnlockView.h"
* 具体例子见：JZGestureUnlockExample

```objc
@class JZGestureUnlockView;
@protocol JZGestureUnlockViewDelegate <NSObject>
/**
 当用户结束触碰滑动解锁View并且存在选中按钮时调用

 @param keyPassWordString 用户选中按钮的tag值按顺序拼接起来的字符串
 */
- (void)gestureUnlockView:(JZGestureUnlockView *)gestureUnlockView userDidEndtouchWithKeyPassWordString:(NSString *)keyPassWordString;


@optional
/**当用户开始触碰滑动解锁View时调用*/
- (void)gestureUnlockViewUserDidBegintouch:(JZGestureUnlockView *)gestureUnlockView;

/**当用户选中一个button时调用（只当button第一次被选中时调用,如用户不结束触摸手势第二次选中button时不调用）*/
- (void)gestureUnlockView:(JZGestureUnlockView *)gestureUnlockView userDidSeletedButtonSeletedButton:(UIButton *)seletedButton;
@end


@interface JZGestureUnlockView : UIView
/**默认图片（请设置）*/
@property(nonatomic, strong) UIImage *defaultImage;

/**选中图片（请设置）*/
@property(nonatomic, strong) UIImage *selectedImage;

/**代理（请设置）*/
@property(nonatomic, weak) id<JZGestureUnlockViewDelegate> delegate;



/**tag起始值（默认0~8）*/
@property(nonatomic, assign) int tagBeginNum;

/**连接线的颜色（默认red）*/
@property(nonatomic, strong) UIColor *lineColor;

/**是否显示连接线（默认显示）*/
@property(nonatomic, assign, getter = isShowLine) BOOL showLine;

/**连接的线宽（默认宽度为10）*/
@property(nonatomic, assign) float lineWidth;
@end
```