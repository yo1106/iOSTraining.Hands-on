//
//  TVSCustomCell.m
//  TableViewSample
//
//  Created by yukichang on 2013/11/21.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "TVSCustomCell.h"

@implementation TVSCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
