//
//  XGCell.m
//  Objective-C_201604
//
//  Created by Yuen on 16/4/19.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "XGCell.h"


@implementation XGCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsZero;
    }
    return self;
}

@end
