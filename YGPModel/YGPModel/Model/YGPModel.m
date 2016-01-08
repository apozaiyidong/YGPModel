/*
 
 https://github.com/apozaiyidong/YGPModel
 
 将 NSDictionary 数据 Mapping 到 @property
 将 C 数据类型转换成 NSNumber
 
 
 apozaiyidong 286677411
 */

#import "YGPModel.h"
#import <UIKit/UIKit.h>
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
        [self mappingWithDictionary:dictionary];
    }
    
    return self;
}

- (void)mappingWithDictionary:(NSDictionary *)dictionary{
    
    if (!dictionary || [dictionary isKindOfClass:[NSNull class]]) {
        NSLog(@"dictionary is nil");
        return;
    }
    
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"dictionary != [NSDictionary class]");
        return;
    }
    
    [self mappingValueWithDictionary:dictionary];
    
}

- (void)mappingValueWithDictionary:(NSDictionary*)dictionary{
    
    [propertyAttributes removeAllObjects];
    
    NSArray *propertyNames = [NSArray arrayWithArray:[self propertyNames]];
    
    for (int i = 0; i<propertyNames.count; i++) {
        
        NSString *key   = propertyNames[i];
        id        value = dictionary[key];
        
        [self adpterValue:value forKey:key propertyAtts:propertyAttributes[i]];
        
    }
}

- (void)adpterValue:(id)value forKey:(NSString*)key propertyAtts:(NSString*)propertyAtts{
    
    NSDictionary *underlyingDataTypes = [self underlyingDataTypes];
    Class cls = [self className_Property:propertyAtts underlyingTypes:underlyingDataTypes];
    
    if ([self isNull:value]){
        NSLog(@"%@  没有设置 value",key);
        if ([cls isSubclassOfClass:[NSNumber class]]) {
            [self setValue:@0 forKey:key];
        }else{
            [self setValue:nil forKey:key];
        }
        return;
    }
    
    //类型匹配直接赋值
    if ([value isKindOfClass:[cls class]]) {
        [self setValue:value forKey:key];
        return;
    }
    
    if ([propertyAtts contains:@"NSURL"]) {
        if ([value isKindOfClass:[NSString class]]) {
            
            NSURL *url = [NSURL URLWithString:value];
            [self setValue:url forKey:key];
            
            return;
        }
    }//NSURL
    else if ([propertyAtts contains:@"NSDate"]) {
        if ([value isKindOfClass:[NSString class]]) {
            NSDate *date = [[YGPModel dateFormatter] dateFromString:value];
            if (date) {
                [self setValue:date forKey:key];
                return;
            }
        }
        
    }//NSDate
    else if ([propertyAtts contains:@"Array"]){
        
        if (![value isKindOfClass:cls]) {
            
            NSLog(@" %@ vs %@ 类型不一致",value,key);
            
            return;
        }
        
    }//NSArray
    else if ([propertyAtts contains:@"Dictionary"]){
        
        if (![value isKindOfClass:cls]) {
            
            NSLog(@" %@ vs %@ 类型不一致",value,key);
            
            return;
        }
    }//NSDictionary
    
    
    [self setValue:nil forKey:key];
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
        
        //不处理只读操作的属性
        NSArray  *p  = [property_getAttributesStr componentsSeparatedByString:@","];
        NSString *rw = p[1];
        
        if ([rw contains:@"R"]) {
            continue;
        }
        
        [propertyAttributes addObject:property_getAttributesStr];
        
        const char* propertyName = property_getName(properties[i]);
        [array addObject: [NSString stringWithUTF8String:propertyName]];
        
    }
    
    free(properties);
    
    return array;
}

- (Class)className_Property:(NSString*)property underlyingTypes:(NSDictionary*)underlyingTypes{
    
    Class propertyCalss;
    
    if (property) {
        
        NSArray *p = [property componentsSeparatedByString:@","];
        NSString *typeString = p[0];
        
        if ([typeString contains:@"@"]) {
            
            if (typeString.length >3) {
                
                typeString = [typeString substringWithRange:NSMakeRange(1, typeString.length - 1)];
                typeString = [typeString substringWithRange:NSMakeRange(2, typeString.length - 3)];
                
                propertyCalss = NSClassFromString(typeString);
                
            }
        }else{
            
            typeString = [typeString substringWithRange:NSMakeRange(1, typeString.length - 1)];
            
            propertyCalss = NSClassFromString(underlyingTypes[typeString]);
        }
        
    }
    return propertyCalss;
}

- (NSDictionary *)underlyingDataTypes{
    
    NSString *numberClass = NSStringFromClass([NSNumber class]);
    NSString *valueClass  = NSStringFromClass([NSValue class]);
    
    NSMutableDictionary *classNamesDictionary = [[NSMutableDictionary alloc]init];
    
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(int)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(BOOL)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(long)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(char)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(short)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(float)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(double)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(long long)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(unsigned int)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(unsigned char)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(unsigned short)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(unsigned long)]];
    [classNamesDictionary setObject:numberClass forKey:[NSString stringWithUTF8String:@encode(unsigned long long)]];
    
    [classNamesDictionary setObject:valueClass forKey:[NSString stringWithUTF8String:@encode(CGPoint)]];
    [classNamesDictionary setObject:valueClass forKey:[NSString stringWithUTF8String:@encode(CGSize)]];
    [classNamesDictionary setObject:valueClass forKey:[NSString stringWithUTF8String:@encode(CGRect)]];
    [classNamesDictionary setObject:valueClass forKey:[NSString stringWithUTF8String:@encode(NSRange)]];
    
    return classNamesDictionary;
}

+ (NSDateFormatter*)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:sszzz"];
    
    return dateFormatter;
}

@end

@implementation NSString(property_Attributes)

- (BOOL)contains:(NSString*)att{
    
    NSRange range = [self rangeOfString:att options:NSCaseInsensitiveSearch];
    return (range.length == att.length &&range.location !=NSNotFound);
}

@end
