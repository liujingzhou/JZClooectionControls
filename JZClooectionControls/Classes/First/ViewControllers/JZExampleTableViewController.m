//
//  JZExampleTableViewController.m
//  JZClooectionControls
//
//  Created by tcyx on 2017/5/4.
//  Copyright © 2017年 ljz. All rights reserved.
//

#import "JZExampleTableViewController.h"

#import "JZExample.h"
#import "JZGestureUnlockExamVC.h"
#import "JZViscosityBtnExamVC.h"

@interface JZExampleTableViewController ()
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation JZExampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"控件集";
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - setter and getter
- (NSArray *)dataArray {
    if (!_dataArray) {
        JZExample *gestureUnlock = [[JZExample alloc] init];
        gestureUnlock.cellTitleText = @"手势解锁";
        gestureUnlock.pushVcClass = [JZGestureUnlockExamVC class];
        
        JZExample *drawingBoard = [[JZExample alloc] init];
        drawingBoard.cellTitleText = @"画板";
        drawingBoard.pushVcClass = nil;
        
        JZExample *gradientProgress = [[JZExample alloc] init];
        gradientProgress.cellTitleText = @"渐变进度条";
        gradientProgress.pushVcClass = nil;
        
        JZExample *viscosityBtn = [[JZExample alloc] init];
        viscosityBtn.cellTitleText = @"粘性按钮";
        viscosityBtn.pushVcClass = [JZViscosityBtnExamVC class];
        
        _dataArray = @[gestureUnlock,drawingBoard,gradientProgress,viscosityBtn];
    }
    return _dataArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"exampleCell";

    UITableViewCell *exampleCell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!exampleCell) {
        exampleCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        exampleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    JZExample *exam = self.dataArray[indexPath.row];
    exampleCell.textLabel.text = exam.cellTitleText;
   
    return exampleCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JZExample *exam = self.dataArray[indexPath.row];
    UIViewController *vc = [[exam.pushVcClass alloc] init];
    vc.title = exam.cellTitleText;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
