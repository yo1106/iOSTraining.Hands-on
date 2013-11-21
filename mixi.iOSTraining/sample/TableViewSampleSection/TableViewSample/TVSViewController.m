//
//  TVSViewController.m
//  TableViewSample
//
//  Created by 武田 祐一 on 2013/04/22.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "TVSViewController.h"

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

// sectionの数を設定するやつらしい。
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    return 3;
}

// sectionのタイトルを設定するやつらしい。
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%d 番目のセクション", section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"(%d, %d)", indexPath.section, indexPath.row];

    return cell;
}

//　ヘッダの高さをこいつで決めるぜぃ！！！
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120.0;
}

// こいつで実際のヘッダのヴューを設定してるらしい。
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

//　フッタの高さをこいつで決めるぜぃ！！！
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60.0;
}

// こいつで実際のフッタのヴューを設定してるらしい。
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    view.backgroundColor = [UIColor greenColor];
    return view;
}

@end
