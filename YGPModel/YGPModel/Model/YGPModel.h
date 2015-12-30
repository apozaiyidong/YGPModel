/*
 
 https://github.com/apozaiyidong/YGPModel
 
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