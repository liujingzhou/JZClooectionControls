//
//  JZGestureUnlockExamVC.m
//  JZClooectionControls
//
//  Created by tcyx on 2017/5/4.
//  Copyright © 2017年 ljz. All rights reserved.
//

#import "JZGestureUnlockExamVC.h"

#import "JZGestureUnlockView.h"

@interface JZGestureUnlockExamVC () <JZGestureUnlockViewDelegate>
@property(nonatomic, strong) JZGestureUnlockView *gestureUnlockView;
@end

@implementation JZGestureUnlockExamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.gestureUnlockView.center = self.view.center;
    CGRect rect = self.gestureUnlockView.frame;
    rect.size = CGSizeMake(306, 275);
    self.gestureUnlockView.frame = rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - setUP
- (void)setUp {
    self.view.backgroundColor = [UIColor grayColor];
    
    self.gestureUnlockView = [[JZGestureUnlockView alloc] init];
    self.gestureUnlockView.defaultImage = [UIImage imageNamed:@"gesture_node_normal"];
    self.gestureUnlockView.selectedImage = [UIImage imageNamed:@"gesture_node_highlighted"];
    self.gestureUnlockView.delegate = self;
    [self.view addSubview:self.gestureUnlockView];
}

#pragma mark - JZGestureUnlockViewDelegate
- (void)gestureUnlockView:(JZGestureUnlockView *)gestureUnlockView userDidEndtouchWithKeyPassWordString:(NSString *)keyPassWordString {
    NSLog(@"userKeyPassWord:%@",keyPassWordString);
    
}

- (void)gestureUnlockView:(JZGestureUnlockView *)gestureUnlockView userDidSeletedButtonSeletedButton:(UIButton *)seletedButton {
    NSLog(@"第一次选中一个按钮");
}

- (void)gestureUnlockViewUserDidBegintouch:(JZGestureUnlockView *)gestureUnlockView {
    NSLog(@"开始手势解锁");
}

@end
