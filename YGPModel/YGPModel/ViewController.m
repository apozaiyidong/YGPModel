//
//  ViewController.m
//  YGPModel
//


#import "ViewController.h"
#import "YGPHTTPRequest.h"
#import "TestModel.h"
#import "UIImageView+YGPWebImage.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSDictionary *dict = @{@"cc":@(11),@"pp":[NSValue valueWithCGPoint:CGPointMake(20, 20)],@"arr":@[@"test"],@"date":@"2015-12-30 12:06:47 GMT+08:00",@"picSmall":@"test"};
//    
//    TestModel * test = [[TestModel alloc]initWithDictionary:dict];
//    NSLog(@"data--- %@ %@",test.arr,NSStringFromCGPoint(test.pp));


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
