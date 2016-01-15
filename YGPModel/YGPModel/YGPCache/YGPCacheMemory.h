

#import <Foundation/Foundation.h>

@interface YGPCacheMemory : NSObject
@property (nonatomic,assign)NSUInteger memoryCacheCountLimit;

+ (instancetype)sharedMemory;

- (void)setObject:(id)object forKey:(NSString*)key;
- (void)setObject:(id)object forKey:(NSString*)key isEvitable:(BOOL)isEvitable;

- (id)objectForKey:(NSString*)key;

- (void)removeDataForKey:(NSString*)key;
- (void)removeAllData;

- (BOOL)containsDataForKey:(NSString*)key;





@end
