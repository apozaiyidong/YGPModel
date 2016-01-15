//
//  ViewController.m
//  YGPModel
//


#import "ViewController.h"
#import "YGPHTTPRequest.h"
#import "UIImageView+YGPWebImage.h"
#import <objc/runtime.h>
#import "YGPCache/YGPCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSDictionary *dict = @{@"cc":@(11),@"pp":[NSValue valueWithCGPoint:CGPointMake(20, 20)],@"arr":@[@"test"],@"date":@"2015-12-30 12:06:47 GMT+08:00",@"picSmall":@"test"};
//    
//    TestModel * test = [[TestModel alloc]initWithDictionary:dict];
//    NSLog(@"data--- %@ %@",test.arr,NSStringFromCGPoint(test.pp));
    
    for (int i = 0; i<36; i++) {
        NSString *ac = [@(arc4random()%2000) stringValue];
        [[YGPCache sharedCache]setObjectToMemory:ac forKey:[@(i) stringValue]];

    }
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
