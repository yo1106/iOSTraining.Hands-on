//
//  ViewController.m
//  UINavigationControllerSample
//
//  Created by yukichang on 2013/11/15.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
    
    self.title = [NSString stringWithFormat:@"%lu", [self.navigationController.viewControllers count]];
    
    if([self.navigationController.viewControllers count] > 1){

        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"pop" style:UIBarButtonItemStylePlain target:self action:@selector(pressPopButton)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
        
    }


}

- (void)pressPopButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressPushButton:(id)sender{
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
}

@end
