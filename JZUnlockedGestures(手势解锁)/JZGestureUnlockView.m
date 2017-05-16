//
//  JZGestureUnlockView.m
//  JZClooectionControls
//
//  Created by tcyx on 2017/5/1.
//  Copyright © 2017年 ljz. All rights reserved.
//

#import "JZGestureUnlockView.h"

@interface JZGestureUnlockView()

/**选中按钮数组*/
@property(nonatomic,strong)NSMutableArray *selectBtnArray;

/**当前手指移动的点*/
@property(nonatomic,assign)CGPoint curPoint;

/**按钮的宽高*/
@property(nonatomic, assign) CGFloat btnWH;

@end


@implementation JZGestureUnlockView
#pragma mark - init
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUpView];
    [self setUpAttribute];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
        [self setUpAttribute];
    }
    return self;
}

- (void)setUpView{
    
    for (int i = 0; i < 9;  i++) {
        //添加按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //添加按钮时设置一个Tag以便记录每一个选中的按钮
        btn.tag = i + self.tagBeginNum;
        
        //让按钮不能够接受事件,原因是当前按钮会拦截事件.
        btn.userInteractionEnabled = NO;
        
        [self addSubview:btn];
    }
    
}

- (void)setUpAttribute {
    _lineWidth = 10;
    _lineColor = [UIColor redColor];
    _showLine = YES;
    _tagBeginNum = 0;
}

#pragma mark - setter and getter
-(NSMutableArray *)selectBtnArray{
    
    if (_selectBtnArray == nil) {
        _selectBtnArray = [NSMutableArray array];
    }
    return _selectBtnArray;
}

- (void)setDefaultImage:(UIImage *)defaultImage {
    _defaultImage = defaultImage;
    for (UIButton *btn in self.subviews) {
        [btn setImage:defaultImage forState:UIControlStateNormal];
        [btn sizeToFit];
        _btnWH = btn.imageView.frame.size.height;
    }
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    _selectedImage = selectedImage;
    for (UIButton *btn in self.subviews) {
        [btn setImage:selectedImage forState:UIControlStateSelected];
        [btn sizeToFit];
    }
}

#pragma mark - event
/**
 *  获取当前手指所在的点
 *
 *  @param touches touches集合
 *
 *  @return 当前手指所在的点.
 */
- (CGPoint)getCurrentPoint:(NSSet *)touches{
    
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}


/**
 *  判断一个点在不在按钮上.
 *
 *  @param point 当前点
 *
 *  @return 如果在按钮上, 返回当前按钮, 如果不在返回nil.
 */
- (UIButton *)btnRectContainsPoint:(CGPoint)point{

    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}


//手指点击时让按钮成选中状态
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if ([self.delegate respondsToSelector:@selector(gestureUnlockViewUserDidBegintouch:)]) {
        [self.delegate gestureUnlockViewUserDidBegintouch:self];
    }

    //判断当前手指在不在按钮上,如果在按钮上并且按钮不是选中状态，让按钮成为选中状态，并添加到数组中.
    CGPoint curP = [self getCurrentPoint:touches];
    UIButton *btn  = [self btnRectContainsPoint:curP];
    
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        if ([self.delegate respondsToSelector:@selector(gestureUnlockView:userDidSeletedButtonSeletedButton:)]) {
            [self.delegate gestureUnlockView:self userDidSeletedButtonSeletedButton:btn];
        }
        [self.selectBtnArray addObject:btn];
    }
    
}

//手指移动时,按钮选中,连线到当前选中的按钮
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //判断当前手指在不在按钮上,如果在按钮上并且按钮不是选中状态，让按钮成为选中状态，并添加到数组中.
    CGPoint curP = [self getCurrentPoint:touches];
    UIButton *btn  = [self btnRectContainsPoint:curP];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        if ([self.delegate respondsToSelector:@selector(gestureUnlockView:userDidSeletedButtonSeletedButton:)]) {
            [self.delegate gestureUnlockView:self userDidSeletedButtonSeletedButton:btn];
        }
        [self.selectBtnArray addObject:btn];
    }
    
    [self setNeedsDisplay];
    //记录当前手指移动的点.
    self.curPoint = curP;
}

//手指松开时,按钮取消选中状态,清空所有的连线.
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.selectBtnArray.count) {
        
        //取消所有选中的按钮,查看选中按钮的顺序
        NSMutableString *str = [NSMutableString string];
        for (UIButton *btn in self.selectBtnArray) {
            [str appendFormat:@"%ld",(long)btn.tag];
            btn.selected = NO;
        }
        //清空所有的连线.
        [self.selectBtnArray removeAllObjects];
        
        [self setNeedsDisplay];
        
        if ([self.delegate respondsToSelector:@selector(gestureUnlockView:userDidEndtouchWithKeyPassWordString:)]) {
            [self.delegate gestureUnlockView:self userDidEndtouchWithKeyPassWordString:str];
        }
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    int cloumn = 3; //总列数

    CGFloat margin = (self.bounds.size.width - cloumn * _btnWH) / (cloumn + 1); //列间距
    
    int curClounm = 0; //当前列
    int curRow = 0;    //当前行
    
    CGFloat x = 0;
    CGFloat y = 0;
    
    //取出所有的控件
    for (int i = 0; i < self.subviews.count; i++) {
        curClounm = i % cloumn;
        curRow = i / cloumn;
        x = margin + (margin + _btnWH) * curClounm;
        y = (margin + _btnWH) * curRow;
        UIButton *btn = self.subviews[i];
        //按钮尺寸
        CGRect btnFrame = btn.frame;
        btnFrame.origin = CGPointMake(x, y);
        btn.frame = btnFrame;
    }
}

- (void)drawRect:(CGRect)rect {
    //清除之前绘图
    CGContextClearRect(UIGraphicsGetCurrentContext(), rect);
    //如果数组当中没有元素或者不显示连接线,就不让它进行绘图.直接返回.
    if(self.selectBtnArray.count <= 0 || NO == self.isShowLine) return;

    UIBezierPath *path = [UIBezierPath bezierPath];

    for(int i = 0; i < self.selectBtnArray.count;i++){
        UIButton *btn = self.selectBtnArray[i];
        if(i == 0){ //设置起点.
            [path moveToPoint:btn.center];
        }else{ //添加一根线到当前按钮的圆心.
            [path addLineToPoint:btn.center];
        }
    }
    //连完先中的按钮后, 在选中按钮之后,添加一根线到当前手指所在的点.
    [path addLineToPoint:self.curPoint];
    [self.lineColor set];
    [path setLineWidth:self.lineWidth];
    
    [path setLineJoinStyle:kCGLineJoinRound]; //设置线的连接样式
    [path stroke];
}

@end
