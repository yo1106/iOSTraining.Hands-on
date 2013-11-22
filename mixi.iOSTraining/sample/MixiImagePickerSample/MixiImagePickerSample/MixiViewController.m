//
//  MixiViewController.m
//  MixiImagePickerSample
//
//  Created by 田村 航弥 on 2013/04/22.
//  Copyright (c) 2013年 mixi. All rights reserved.
//

#import "MixiViewController.h"

@interface MixiViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
- (IBAction)pressCameraButton:(id)sender;

@end

@implementation MixiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressCameraButton:(id)sender
{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    // UIImagePickerControllerSourceTypeSavedPhotosAlbum だと直接写真選択画面
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 選択したメディアの編集を可能にするかどうか
    // 正方形以外にするためには独自で用意する必要がある
    // フルサイズのメディアの編集や、カスタムトリミングの指定をユーザ側ででき
    // るようにする場合は、独自の編集用UIを提供する必要があります。
    imagePickerVC.allowsEditing = YES;

    // 選択可能なメディアの制限 デフォルトは photo のみ。
    // movie を選択可能にするには
    imagePickerVC.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePickerVC.sourceType];
    imagePickerVC.delegate = self;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark - UIImagePickerDelegate methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];

    UIImage *originImage = info[UIImagePickerControllerOriginalImage];

    //Cropした位置情報取得だぜ
    CGRect rect = CGRectZero;
    [[info objectForKey:UIImagePickerControllerCropRect] getValue:&rect];
    NSLog(@"rect:%@", NSStringFromCGRect(rect));

    /*
    * UIImageのCGImageはOrientationを無視するので、
    * drawInRectで再生性
    * http://blog.katty.in/105
    */
    UIGraphicsBeginImageContext(originImage.size);
    [originImage drawInRect:CGRectMake(0, 0, originImage.size.width, originImage.size.height)];
    originImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(originImage.CGImage, rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];


    self.photoImageView.image = croppedImage;
    NSLog(@"size:%f, %f", croppedImage.size.width, croppedImage.size.height);
}

@end
