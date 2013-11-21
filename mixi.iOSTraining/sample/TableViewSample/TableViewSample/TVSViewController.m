//
//  TVSViewController.m
//  TableViewSample
//
//  Created by 武田 祐一 on 2013/04/22.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "TVSViewController.h"
#import "TVSCustomCell.h"

@interface TVSViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TVSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _tableView.dataSource = self;
    _tableView.delegate = self;

//    利用するcustomViewの名前をnibWithNibNameに指定するのだ。
    [_tableView registerNib:[UINib nibWithNibName:@"TVSCustomCell" bundle:nil] forCellReuseIdentifier:@"maimai"];
    [_tableView registerNib:[UINib nibWithNibName:@"TSVCustomCell2" bundle:nil] forCellReuseIdentifier:@"daisuke"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//        cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row]; // 移動させた
//    }
    NSString *cellId = indexPath.row % 2 == 0 ? @"maimai" : @"daisuke";
    TVSCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.bodyLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TVSViewController *viewController = [[TVSViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
//    self.navigationController.title = [NSString NSFormat;
}

//テーブルのセルの高さを指定
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

@end
