//
//  YGPModel.h
//  YGPModel
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 apozaiyidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGPModel : NSObject

- (id)initWithDictionary:(NSDictionary*)dictionary;
- (void)setDictionary:(NSDictionary *)dictionary;

@end
@interface NSString (property_Attributes)

- (BOOL)contains:(NSString*)att;

@end