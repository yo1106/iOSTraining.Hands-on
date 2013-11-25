//
//  MixiAssetsViewController.m
//  MixiAssetsLibrarySample
//
//  Created by 田村 航弥 on 2013/04/30.
//  Copyright (c) 2013年 mixi. All rights reserved.
//

#import "MixiAssetsViewController.h"

@interface MixiAssetsViewController ()

@property (strong, nonatomic) ALAssetsGroup *assetsGroup;
@property (strong, nonatomic) NSMutableArray *assets;
@property (strong, nonatomic) NSMutableArray *selectedIndices;
@property (strong, nonatomic) NSMutableArray *selectedAssetsURL;

@property (weak, nonatomic) IBOutlet UITableView *assetsTableView;

@end

@implementation MixiAssetsViewController

- (id)initWithAssetsGroup:(ALAssetsGroup *)assetsGroup
{
    self = [super initWithNibName:@"MixiAssetsViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _assetsGroup = assetsGroup;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pressDoneButton)];

    _assets = [NSMutableArray array];
    _selectedIndices = [NSMutableArray array];
    [_assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//        NSLog(@"asset %@", result);
        if(result) [_assets addObject:result];
        else [_assetsTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_assets count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }

    ALAsset *asset = _assets[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [asset valueForProperty:ALAssetPropertyDate]];
    [cell.imageView setImage:[UIImage imageWithCGImage:[asset thumbnail]]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //選択されてるインデックスを保持しておく。
    if([self.selectedIndices containsObject:indexPath]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // TODO : accessoryType が UITableViewCellAccessoryNone だったら UITableViewCellAccessoryCheckmark を、逆なら None を設定する
    if(cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
//    NSLog(@"%@", indexPath);
    //TODO : 選択された場合 index を _selectedIndices に add する、選択解除された場合 _selectedIndices から index を削除する
    if(cell.accessoryType == UITableViewCellAccessoryCheckmark){
        [self.selectedIndices addObject:indexPath];
    }else{
        [self.selectedIndices removeObject:indexPath];
    }
    
    //TODO : このままだと _selectedIndices は順番が cell がおかしいので、_selectedIndices をソートする必要がある。ここでソートする。
    // なんでソート必要なのか判らんけどとりあえずソートしてみる
//    NSLog(@"beforeSort:%@", self.selectedIndices);
    [self.selectedIndices sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2];
    }];
//    NSLog(@"afterSort:%@", self.selectedIndices);
}

#pragma mark - private methods
-(void)pressDoneButton
{
    //TODO : _selectedAssets初期化
    self.selectedAssetsURL = [NSMutableArray array];

    //TODO : _selectedIndices に入ってる index の　asset を _assets から取得して、_selectedAssets に add する。
    for(NSIndexPath *index in self.selectedIndices){
        ALAsset *asset = self.assets[(long)index.row];
        NSString *assetURL = [[asset valueForProperty:ALAssetPropertyURLs] objectForKey:[[asset defaultRepresentation] UTI]];
        [self.selectedAssetsURL addObject:assetURL];
    }

    //TODO : delegate methods コールして assets 渡す
    [self.delegate assetsViewControllerDidSelectedPhotos:self.selectedAssetsURL];
}



@end