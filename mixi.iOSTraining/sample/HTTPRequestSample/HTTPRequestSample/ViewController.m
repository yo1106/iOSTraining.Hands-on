//
//  ViewController.m
//  HTTPRequestSample
//
//  Created by yukichang on 2013/11/25.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "ViewController.h"
#import "CoordinateView.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *coordinates;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURL *url = [NSURL URLWithString:@"http://api.coorde.me/v1/coordinates/?limit=20&filter=hot"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url]; //シンプルな方法

    // 同期読み込み
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:NSJSONReadingAllowFragments error:&error];
    self.coordinates = dic[@"coordinates"];
    
    //非同期での読み込み
//    NSOperationQueue *queue = [NSOperationQueue new];
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *res, NSData *data, NSError *error) {
//        
//        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
//                                                                   options:NSJSONReadingAllowFragments error:&error];
//        self.coordinates = dic[@"coordinates"];
////        NSLog(@"%@", self.coordinates);
//    }];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CoordinateView" bundle:nil] forCellReuseIdentifier:@"coordinateView"];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.coordinates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoordinateView *cell = [tableView dequeueReusableCellWithIdentifier:@"coordinateView"];
    if (cell == nil) {
        cell = [[CoordinateView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSMutableDictionary *coordinate = self.coordinates[indexPath.row];
//    NSLog(@"%@", coordinate[@"title"]);
    cell.titleLabel.text = coordinate[@"title"];
    
    
    cell.image.image = [UIImage imageNamed:@"Placeholder.png"];
    [cell.image loadImage:coordinate[@"images"][0]];
    return cell;
}
//テーブルのセルの高さを指定
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
