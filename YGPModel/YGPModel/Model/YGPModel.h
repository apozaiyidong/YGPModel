/*
 
 https://github.com/apozaiyidong/YGPModel
 
 将 NSDictionary 数据 Mapping 到 @property
 将 C 数据类型转换成 NSNumber
 
 
 apozaiyidong 286677411 
 */

#import <Foundation/Foundation.h>

@interface YGPModel : NSObject

- (id)initWithDictionary:(NSDictionary*)dictionary;
- (void)mappingWithDictionary:(NSDictionary *)dictionary;

@end

@interface NSString (property_Attributes)
- (BOOL)contains:(NSString*)att;
@end