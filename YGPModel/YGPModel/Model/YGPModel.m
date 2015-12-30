//
//  YGPModel.m
//  YGPModel
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 apozaiyidong. All rights reserved.
//

#import "YGPModel.h"
#import <objc/runtime.h>

@interface YGPModel ()
{
    NSMutableArray *propertyAttributes;
}
@end
@implementation YGPModel

- (id)initWithDictionary:(NSDictionary *)dictionary{


    if (self = [super init]) {
        propertyAttributes = [[NSMutableArray alloc]init];
        [self setDictionary:dictionary];
    }
    
    return self;
}

- (void)setDictionary:(NSDictionary *)dictionary{
    
    if (!dictionary || [dictionary isKindOfClass:[NSNull class]]) {
        NSLog(@"dictionary is nil");
        return;
    }
    
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"dictionary != [NSDictionary class]");
        return;
    }
    
    [self adpterValueWithDictionary:dictionary];

}

- (void)adpterValueWithDictionary:(NSDictionary*)dictionary{
    
    [propertyAttributes removeAllObjects];
    
    NSArray *propertyNames = [NSArray arrayWithArray:[self propertyNames]];
    
    for (int i = 0; i<propertyNames.count; i++) {
        
        NSString *key   = propertyNames[i];
        id        value = dictionary[key];
        
        if ([self isNull:value]){
            [self setValue:nil forKey:key];
            continue;
        }
        
       [self adpterValue:value forKey:key propertyAtts:propertyAttributes[i]];
        
    }
    
}

- (void)adpterValue:(id)value forKey:(NSString*)key propertyAtts:(NSString*)propertyAtts{
    
    if ([value isKindOfClass:[NSNumber class]]) {
        NSLog(@"value %@",value);
    }else if([value isKindOfClass:[NSValue class]]){
        NSLog(@"value %@",value);
    
    }
    
    
    if ([propertyAtts contains:@"NSURL"]) {
        
        if ([value isKindOfClass:[NSString class]]) {
                NSURL *url = [NSURL URLWithString:value];
                [self setValue:url forKey:key];
                    return;
        }//NSURL
        else if ([propertyAtts contains:@"NSDate"]){
            
            if ([value isKindOfClass:[NSDate class]]) {
                
            }
            
        }//NSDate
        else if ([propertyAtts contains:@"Array"]){
        
            if (![value isKindOfClass:[NSArray class]]) {
                NSLog(@"YGPModel Error: %@ type != %@ ",key,value);
            }
            
        }//Array
        else if ([propertyAtts contains:@"Dictionary"]){
            
            if (![value isKindOfClass:[NSDictionary class]]) {
                NSLog(@"YGPModel Error: %@ type !=  %@ ",key,value);
            }
            
        }//NSDictionary
    }
            
    [self setValue:value forKey:key];
}

- (BOOL)isNull:(id)obj{
    
    if (!obj) return YES;
    if ([obj isKindOfClass:[NSNull class]])return YES;
    
    if (obj == nil)return YES;
    
    return NO;
}

- (NSArray *)propertyNames
{
    u_int count;
    
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    NSMutableArray  *array = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i<count; i++)
    {
        
        //property_getAttributes
        const char *attrs = property_getAttributes(properties[i]);
        NSString *property_getAttributesStr = [NSString stringWithCString:attrs encoding:NSASCIIStringEncoding];
        NSLog(@"%s",attrs);
        //不处理只读操作的属性
        if ([property_getAttributesStr contains:@"R"]) {
            continue;
        }
        
        [propertyAttributes addObject:property_getAttributesStr];
        
        const char* propertyName =property_getName(properties[i]);
        [array addObject: [NSString stringWithUTF8String:propertyName]];
        
        
    }
    
    free(properties);
    
    return array;
}

@end

@implementation NSString(property_Attributes)

- (BOOL)contains:(NSString*)att{

    NSRange range = [self rangeOfString:att options:NSCaseInsensitiveSearch];
    return (range.length == att.length &&range.location !=NSNotFound);
}

@end
