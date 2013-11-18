//
//  FocusViewController.m
//  ThumbnailFocus
//
//  Created by 鄭 基旭 on 2013/04/18.
//  Copyright (c) 2013年 鄭 基旭. All rights reserved.
//

#import "FocusViewController.h"

static NSTimeInterval const kDefaultOrientationAnimationDuration = 0.4;

@interface FocusViewController ()
@property (nonatomic, assign) UIDeviceOrientation previousOrientation;
@end

#warning 「⬇ Answer：」マークがあるラインにコメントで簡単な解説文を書いてください。

@implementation FocusViewController

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mainImageView = nil;
    self.contentView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // ⬇Answer：UIDeviceOrientationDidChangeNotificationの通知がされた時にorientationDidChangeNotificationメソッドを呼び出すように通知要求を登録
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationDidChangeNotification:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
    // ⬇Answer：デバイスの向きが変わる始まり通知を送ってる
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // ⬇Answer：上で登録してる通知要求を削除
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    // ⬇Answer：デバイスの向きが変わる終わり通知を送ってる
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (NSUInteger)supportedInterfaceOrientations
{
    // ⬇Answer： 縦表示（ホームボタン下）を許可
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)isParentSupportingInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    switch(toInterfaceOrientation)
    {
        case UIInterfaceOrientationPortrait:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskPortrait;

        case UIInterfaceOrientationPortraitUpsideDown:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskPortraitUpsideDown;

        case UIInterfaceOrientationLandscapeLeft:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeLeft;

        case UIInterfaceOrientationLandscapeRight:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeRight;
    }
}


/////////////////////////////////////////////////////////////
// ⬇Answer： 次の関数は回転時のアニメーションを担当しています。
//　82ラインから140ラインまで、すべてのラインにコメントを書いてください。
/////////////////////////////////////////////////////////////
- (void)updateOrientationAnimated:(BOOL)animated
{
    CGAffineTransform transform;
    NSTimeInterval duration = kDefaultOrientationAnimationDuration;

//   さっき回転したのと同じなら処理を止める
    if([UIDevice currentDevice].orientation == self.previousOrientation)
        return;

//    さっきと上下反転してたらdurationを倍に
    if((UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation) && UIInterfaceOrientationIsLandscape(self.previousOrientation))
       || (UIInterfaceOrientationIsPortrait([UIDevice currentDevice].orientation) && UIInterfaceOrientationIsPortrait(self.previousOrientation)))
    {
        duration *= 2;
    }

//    縦になったり、対応してるOrientationなら
    if(([UIDevice currentDevice].orientation == UIInterfaceOrientationPortrait)
       || [self isParentSupportingInterfaceOrientation:(UIInterfaceOrientation)[UIDevice currentDevice].orientation]) {
//      プロパティをもとに戻す感じ？
        transform = CGAffineTransformIdentity;
    }else {
        switch ([UIDevice currentDevice].orientation){
            case UIInterfaceOrientationLandscapeLeft:
                if(self.parentViewController.interfaceOrientation == UIInterfaceOrientationPortrait) {
                    transform = CGAffineTransformMakeRotation(-M_PI_2);
                }else {
                    transform = CGAffineTransformMakeRotation(M_PI_2);
                }
                break;

            case UIInterfaceOrientationLandscapeRight:
                if(self.parentViewController.interfaceOrientation == UIInterfaceOrientationPortrait) {
                    transform = CGAffineTransformMakeRotation(M_PI_2);
                }else {
                    transform = CGAffineTransformMakeRotation(-M_PI_2);
                }
                break;

            case UIInterfaceOrientationPortrait:
                transform = CGAffineTransformIdentity;
                break;

            case UIInterfaceOrientationPortraitUpsideDown:
                transform = CGAffineTransformMakeRotation(M_PI);
                break;

            case UIDeviceOrientationFaceDown:
            case UIDeviceOrientationFaceUp:
            case UIDeviceOrientationUnknown:
                return;
        }
    }

    CGRect frame = CGRectZero;
//    アニメーションのフラグが立ってたらアニメーションさせてそうじゃなかったら一気にいく！
    if(animated) {
        frame = self.contentView.frame;
        [UIView animateWithDuration:duration
                         animations:^{
                             self.contentView.transform = transform;
                             self.contentView.frame = frame;
                         }];
    }else {
        frame = self.contentView.frame;
        self.contentView.transform = transform;
        self.contentView.frame = frame;
    }
//    今回転したOrientationを保持しとく
    self.previousOrientation = [UIDevice currentDevice].orientation;
}

#pragma mark - Notifications
// ⬇Answer：こちはいつ呼ばれますか？
- (void)orientationDidChangeNotification:(NSNotification *)notification
{
    [self updateOrientationAnimated:YES];
}
@end