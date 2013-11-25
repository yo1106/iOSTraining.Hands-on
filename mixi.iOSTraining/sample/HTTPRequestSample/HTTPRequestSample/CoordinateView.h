//
//  CoordinateView.h
//  HTTPRequestSample
//
//  Created by yukichang on 2013/11/25.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIAsyncImageView.h"

@interface CoordinateView : UITableViewCell
@property (strong, nonatomic) IBOutlet UIAsyncImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
