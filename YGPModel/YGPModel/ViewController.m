//
//  ViewController.m
//  YGPModel
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 apozaiyidong. All rights reserved.
//

#import "ViewController.h"
#import "YGPHTTPRequest.h"
#import "TestModel.h"
#import "UIImageView+YGPWebImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = @{@"cc":@(11),@"pp":[NSValue valueWithCGPoint:CGPointMake(20, 20)],@"arr":@[@"asdccc"],@"date":@"2015-12-30 12:06:47 GMT+08:00",@"picSmall":@"aaaa"};
    
    TestModel * test = [[TestModel alloc]initWithDictionary:dict];
    NSLog(@"data--- %@ %@",test.arr,NSStringFromCGPoint(test.pp));
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
