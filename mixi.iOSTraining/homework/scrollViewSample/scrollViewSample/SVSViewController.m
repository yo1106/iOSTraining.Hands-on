//
//  SVSViewController.m
//  scrollViewSample
//
//  Created by 武田 祐一 on 2013/04/19.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "SVSViewController.h"

@interface SVSViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SVSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //    _scrollViewを使うより、self.scrollViewを使うクセを付けたほうが、setter,getterを使えるため良い。ｂｙたまやま
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];

    UIImage *image = [UIImage imageNamed:@"big_image.jpg"];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    self.imageView.image = image;

    
    self.scrollView.contentSize = self.imageView.frame.size;
    self.scrollView.delegate = self;

    
//    xibに書いてあるのに、なぜかaddSubviewせんと動かん。。。(´・ω・`)
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.scrollView];

    //    タップで一番上にスクロールする設定らしいけど上に行かない＼(^o^)／
    self.scrollView.scrollsToTop = YES;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.scrollView setContentOffset:CGPointMake(500, 0) animated:YES];
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (UIView *view in scrollView.subviews){
        if([view isKindOfClass:[UIImageView class]]){
            return view;
        }
    }
    return nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll:x=%f,y=%f", scrollView.contentOffset.x, scrollView.contentOffset.y);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
