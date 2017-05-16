//
//  JZViscosityBtnExamCell.m
//  JZClooectionControls
//
//  Created by tcyx on 2017/5/15.
//  Copyright © 2017年 ljz. All rights reserved.
//

#import "JZViscosityBtnExamCell.h"

#import "JZViscosityBtn.h"

@implementation UITableView(JZViscosityBtnExamCell)

- (JZViscosityBtnExamCell *)JZViscosityBtnExamCell {
    static NSString *CellIdentifier = @"JZViscosityBtnExamCell";
    
    JZViscosityBtnExamCell * cell = (JZViscosityBtnExamCell *)[self dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[JZViscosityBtnExamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end

@interface JZViscosityBtnExamCell ()

@end

@implementation JZViscosityBtnExamCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

- (void)initView{
    JZViscosityBtn *viscosityBtn = [[JZViscosityBtn alloc] init];
    [self.contentView addSubview:viscosityBtn];
    
//    viscosityBtn.frame = CGRectMake(355, 17, 10, 10);
    [viscosityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.right.mas_equalTo(self.contentView).with.offset(-10);
        make.centerY.mas_equalTo(self.contentView);
        
    }];
}

@end
