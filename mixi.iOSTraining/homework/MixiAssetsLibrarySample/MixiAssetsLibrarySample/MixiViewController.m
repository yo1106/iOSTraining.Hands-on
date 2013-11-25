//
//  MixiViewController.m
//  MixiAssetsLibrarySample
//
//  Created by 田村 航弥 on 2013/04/30.
//  Copyright (c) 2013年 mixi. All rights reserved.
//

#import "MixiViewController.h"
#import "MixiAssetsGroupViewController.h"

@interface MixiViewController ()
@property (weak, nonatomic) IBOutlet UITableView *selectedPhotoTableView;
@property (strong, nonatomic) NSArray *selectedAssetsURL;

- (IBAction)pressShowAssetsGroupButton:(id)sender;
@end

@implementation MixiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.selectedAssetsURL = [NSArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressShowAssetsGroupButton:(id)sender
{
    MixiAssetsGroupViewController *assetsGroupVC = [[MixiAssetsGroupViewController alloc] initWithNibName:@"MixiAssetsGroupViewController" bundle:nil];
    assetsGroupVC.delegate = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:assetsGroupVC];
    [self presentViewController:nc animated:YES completion:nil];
}

#pragma mark - MixiAssetsViewControllerDelegate methods
-(void)assetsViewControllerDidSelectedPhotos:(NSArray *)assetsURL
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.selectedAssetsURL = assetsURL;
    [_selectedPhotoTableView reloadData];
}

#pragma mark - UITableViewDatasource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d", self.selectedAssetsURL.count);
    return [self.selectedAssetsURL count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }

    NSURL *assetURL = self.selectedAssetsURL[indexPath.row];
    
    // ALAssetで取得するとlifetimeが超えてしまい取得出来ないので、assetForURLを使いURLから生成する。
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary assetForURL:assetURL
                  resultBlock:^(ALAsset *asset) {
                      // 結果取得時に実行されるブロック

                      cell.textLabel.text = [NSString stringWithFormat:@"%@", [asset valueForProperty:ALAssetPropertyDate]];
                      NSLog(@"%@", cell.textLabel.text);
                      [cell.imageView setImage:[UIImage imageWithCGImage:[asset thumbnail]]];
                      [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

                      //これを書いておかないと最初にCellが表示する時に表示されない。
                      [cell layoutSubviews];
                  }
                 failureBlock:^(NSError *error) {
                     // 結果取得時に実行されるブロック
                     NSLog(@"falt");
                 }];
    return cell;

}


#pragma mark - UITableViewDelegate methods

@end
