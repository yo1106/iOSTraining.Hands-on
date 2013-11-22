//
//  TVSCustomCell.m
//  TableViewSample
//
//  Created by 武田 祐一 on 2013/04/23.
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


-(CGFloat)calculateCellHeightWithText:(NSString *)text
{
    // TODO : UILabel の高さ計算 [2]
    // HINT : (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode

    //表示最大サイズ
    CGSize bounds = CGSizeMake(self.bodyLabel.frame.size.width, CGFLOAT_MAX);
    NSLineBreakMode mode = self.bodyLabel.lineBreakMode;//改行する
    CGSize size = [text sizeWithFont:self.bodyLabel.font constrainedToSize:bounds lineBreakMode:mode];
    
    CGFloat top = 20.0f;
    CGFloat bottom = 20.0f;
    return size.height + top + bottom;
}

@end
