//
//  TestModel.h
//  YGPModel
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 apozaiyidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGPModel.h"
#import <UIKit/UIKit.h>
@interface TestModel : YGPModel
@property (nonatomic,strong)NSURL *picSmall;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSArray  *data;
@property (nonatomic,strong)NSNumber *learner;
@property (nonatomic,strong,readonly)NSString *chi;
@property (nonatomic,assign) int cc;
@property (nonatomic,assign) CGPoint pp;

@end
