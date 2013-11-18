//
//  MainViewController.m
//  ThumbnailFocus
//
//  Created by 鄭 基旭 on 2013/04/18.
//  Copyright (c) 2013年 鄭 基旭. All rights reserved.
//

#import "MainViewController.h"
#import "ThumbnailsViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) ThumbnailsViewController *thumbnailsViewController;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@end

@implementation MainViewController

static CGRect const kPortraitViewRect = { { 32.0f, 18.0f }, { 150.0f, 150.0f } };
static CGRect const kLandscapeViewRect = { { 180.0f, 32.0f }, { 150.0f, 150.0f } };

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.thumbnailsViewController = [[ThumbnailsViewController alloc] initWithNibName:nil bundle:nil];
    [self addChildViewController:self.thumbnailsViewController];
    [self.contentView addSubview:self.thumbnailsViewController.view];
    self.thumbnailsViewController.view.frame = self.contentView.bounds;
    self.view.clipsToBounds = NO;
}

#warning ⬇ HomeWork　iPadの場合は回転に対応してください。device orientationにて設定した！！
//- (NSUInteger)supportedInterfaceOrientations
//{
//    NSLog(@"rotate support on ios6");
//    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
//}
//
//-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//                                        duration:(NSTimeInterval)duration
//{
//    NSLog(@"will animate");
//    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
//        [_contentView setFrame:kPortraitViewRect];
//
//    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight
//               || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
//    {
//        [_contentView setFrame:kLandscapeViewRect];
//    }
//}


#warning ⬇ HomeWork　スーパークラスが動いてるんじゃねぇのかな？
/*ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
// １。５０ラインからのメソッドはコメント処理したのに、なんでうまく動いているか？ 考えてみてください。
// ２。下記は必ず覚えていきましょう
ー【UIViewControllerのViewロードに関する主要デリゲートメソッド】ーー
-(void)viewDidLoad	初回ロードされた時のみ呼び出される
-(void)viewWillAppear:(BOOL)animated	画面が表示される都度呼び出される
-(void)viewDidAppear:(BOOL)animated	画面が表示された後に呼び出される
-(void)viewWillDisappear:(BOOL)animated	画面が閉じる前に呼び出される
-(void)viewDidDisappear:(BOOL)animated	画面が閉じた後に呼び出される
-(void)viewDidUnload	画面がアンロードされたときに呼び出される
-(void)didReceiveMemoryWarning	メモリ不足時に呼び出される
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー*/
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
*/
@end
