//
//  UIAsyncImageView.h
//  HTTPRequestSample
//
//  Created by yukichang on 2013/11/25.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAsyncImageView : UIImageView {
@private
    NSURLConnection *conn;
    NSMutableData *data;
}
-(void)loadImage:(NSString *)url;
-(void)abort;
@end
