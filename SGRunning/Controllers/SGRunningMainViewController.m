//
//  SGRunningMainViewController.m
//  SGRunning
//
//  Created by 孙冠 on 16/11/3.
//  Copyright © 2016年 sunguan. All rights reserved.
//

#import "SGRunningMainViewController.h"
#import "SGSportingViewController.h"
#import "SGSportTracking.h"

@interface SGRunningMainViewController ()

@end

@implementation SGRunningMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//开始运动的方法，根据sender的tag值来判断什么方式的运动
- (IBAction)startRunning:(UIButton *)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SGSportingView" bundle:nil];
    
    SGSportingViewController *sportVC = sb.instantiateInitialViewController;
    
    sportVC.sportType = sender.tag;
    
    [self presentViewController:sportVC animated:YES completion:nil];
}



@end
