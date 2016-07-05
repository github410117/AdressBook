//
//  cellTableViewCell.h
//  我的通讯录
//
//  Created by etcxm on 16/5/23.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
