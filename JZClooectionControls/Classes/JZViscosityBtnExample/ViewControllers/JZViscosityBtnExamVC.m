//
//  JZViscosityBtnExamVC.m
//  JZClooectionControls
//
//  Created by tcyx on 2017/5/15.
//  Copyright © 2017年 ljz. All rights reserved.
//

#import "JZViscosityBtnExamVC.h"

#import "JZViscosityBtnExamCell.h"

@interface JZViscosityBtnExamVC ()

@end

@implementation JZViscosityBtnExamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"粘性按钮";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(reload)];
    self.tableView.tableFooterView = [[UIView alloc] init];
//    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)reload {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZViscosityBtnExamCell *viscosityBtnExamCell = [tableView JZViscosityBtnExamCell];

    return viscosityBtnExamCell;
}

@end
