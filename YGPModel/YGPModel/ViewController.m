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
{

    __block NSString *aa;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    
    [dict setObject:@"aa" forKey:@"22"];
    
    NSString *caa = dict[@"22"];
    caa = @"cc";
    
    NSLog(@"dict %@",dict);
    
    aa = @"";
    [[YGPCache sharedCache]setObjectToMemory:@"aaa" forKey:@"1"];
    [[YGPCache sharedCache] objectFormMemoryForKey:@"1" block:^(id object, NSString *key) {
        aa = object;
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self
                                   selector:@selector(aaa) userInfo:nil repeats:NO];
    
//    for (int i = 0; i<36; i++) {
//        NSString *ac = [@(arc4random()%2000) stringValue];
//        [[YGPCache sharedCache]setObjectToMemory:ac forKey:[@(i) stringValue]];
//
//    }
   
    
}
- (void)aaa{
    NSLog(@"来了诶有");
    [[YGPCache sharedCache]setObjectToMemory:@"22" forKey:@"1"];

    NSLog(@"%@",aa);
    [[YGPCache sharedCache] objectFormMemoryForKey:@"1" block:^(id object, NSString *key) {
        NSLog(@"object %@",object);
        NSLog(@"%@",aa);

    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
