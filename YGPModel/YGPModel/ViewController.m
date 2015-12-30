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
    
    NSString     *url = @"http://www.imooc.com/api/teacher";
    NSDictionary *params = @{@"type":@"4",@"num":@"30"};
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 50, 100, 100)];
    [self.view addSubview:imageView];
//    [imageView YGP_setImageWithURL:[NSURL URLWithString:@"http://img.mukewang.com/55237dcc0001128c06000338-300-170.jpg"]];
    NSLog(@"--- %@",[NSString stringWithUTF8String:@encode(int)]);
    NSLog(@"--- %@",[NSString stringWithUTF8String:@encode(CGPoint)]);

    [[YGPHTTPRequest sharedRequest]GET:url params:params success:^(NSURLRequest *urlRequest, id responseData) {
//        NSLog(@"%@",responseData[@"data"]);
        
        NSDictionary *dict = @{@"cc":@(11),@"pp":[NSValue valueWithCGPoint:CGPointMake(20, 20)]};
        
        TestModel * test = [[TestModel alloc]initWithDictionary:dict];
//        NSLog(@"data--- %@",test.data);
//        [test setDictionary:test.data[0]];
//        NSLog(@"%@",test.learner);
        
//        NSLog(@"%@ -- %@",test.picSmall,test.name);
        
        [imageView YGP_setImageWithURL:nil];
    } failure:^(NSURLRequest *urlRequest, NSError *error) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
