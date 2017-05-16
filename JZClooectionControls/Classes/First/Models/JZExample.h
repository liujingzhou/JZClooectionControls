//
//  JZExample.h
//  JZClooectionControls
//
//  Created by tcyx on 2017/5/4.
//  Copyright © 2017年 ljz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZExample : NSObject

/**cell标题文字*/
@property (strong, nonatomic) NSString *cellTitleText;

/**push的VC*/
@property (assign, nonatomic) Class pushVcClass;
@end
