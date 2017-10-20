//
//  ViewController.m
//  CYKeychainStore
//
//  Created by DeepAI on 2017/10/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "ViewController.h"
#import "CYDeviceUUIDManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@",[CYDeviceUUIDManager deviceUUID]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
