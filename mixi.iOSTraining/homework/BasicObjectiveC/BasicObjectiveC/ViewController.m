//
//  ViewController.m
//  BasicObjectiveC
//
//  Created by 武田 祐一 on 2013/04/16.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "ViewController.h"
#import "TestQueue.h"
#import "TestStack.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // TODO ここに課題を書き進めていってください
    NSArray *dict = @[
                           @{
                               @"domain":   @"mixi.jp",
                               @"entry":    @[
                                                @"list_voice.pl",
                                                @"list_diary.pl",
                                                @"list_mymall_item.pl"
                                            ]
                            },
                           @{
                               @"domain":   @"mmall.jp",
                               @"entry":    @{
                                                @"path":@"add_diary.pl",
                                                @"query":@{
                                                            @"tag_id":@7
                                                        }
                                                },
                               },
                           @{
                               @"domain":@"itunes.apple.com"
                               },
                           ];
    NSDictionary *addDict = @{
                              @"domain":    @"coorde.me",
                              @"entry": @[
                                        @"timeline",
                                        @"coordinates",
                                      ],
                              };
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i=0; i<dict.count; i++) {
        [mutableArray addObject:dict[i]];
    }
    [mutableArray addObject:addDict];
    

    TestQueue *queue = [[TestQueue alloc] init];
    NSLog(@"size:%d", [queue size]);
    
    [queue push:@"hoge"];
    [queue push:@"huga"];
    [queue push:@"foo"];
    [queue push:@"bar"];
    
    NSLog(@"size:%d", [queue size]);
    NSLog(@"pop:%@", [queue pop]);
    NSLog(@"pop:%@", [queue pop]);

    TestStack *stack = [[TestStack alloc] init];
    NSLog(@"size:%d", [stack size]);
    
    [stack push:@"hoge"];
    [stack push:@"huga"];
    [stack push:@"foo"];
    [stack push:@"bar"];
    
    NSLog(@"size:%d", [stack size]);
    NSLog(@"pop:%@", [stack pop]);
    NSLog(@"pop:%@", [stack pop]);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
