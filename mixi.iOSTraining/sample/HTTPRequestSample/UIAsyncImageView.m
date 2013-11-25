//
//  UIAsyncImageView.m
//  HTTPRequestSample
//
//  Created by yukichang on 2013/11/25.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "UIAsyncImageView.h"

@implementation UIAsyncImageView

-(void)loadImage:(NSString *)url{
    [self abort];
    self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    data = [[NSMutableData alloc] initWithCapacity:0];
    
    NSURLRequest *req = [NSURLRequest
                         requestWithURL:[NSURL URLWithString:url]
                         cachePolicy:NSURLRequestUseProtocolCachePolicy
                         timeoutInterval:30.0];
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
//    NSLog(@"loadImage");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)nsdata{
    [data appendData:nsdata];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self abort];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    self.image = [UIImage imageWithData:data];
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    NSLog(@"connectionDidFinishLoading");
    [self abort];
}

-(void)abort{
//    NSLog(@"abort");
    if(conn != nil){
        [conn cancel];
        conn = nil;
    }
    if(data != nil){
        data = nil;
    }
}

- (void)dealloc {
    [conn cancel];
}

@end
