/*
 
 https://github.com/apozaiyidong/YGPModel
 
 将 NSDictionary 数据 Mapping 到 @property
 将 C 数据类型转换成 NSNumber
 基础数据类型如果没有对应的值默认设置 0 
 
*/

#import <Foundation/Foundation.h>

@interface YGPModel : NSObject

/**
 *  实例化方法
 *
 *  @param dictionary 映射的NSDictionary object
 *
 *  @return
 */
- (id)initWithDictionary:(NSDictionary*)dictionary;

/**
 *  如果不设置上面的初始化方法，就可使用此方法来映射值
 *
 *  @param dictionary <#dictionary description#>
 */
- (void)mappingWithDictionary:(NSDictionary *)dictionary;

@end

@interface NSString (property_Attributes)
- (BOOL)contains:(NSString*)att;
@end