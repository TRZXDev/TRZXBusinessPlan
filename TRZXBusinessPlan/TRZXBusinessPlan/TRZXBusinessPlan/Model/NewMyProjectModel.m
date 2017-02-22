//
//  NewMyProjectModel.m
//  tourongzhuanjia
//
//  Created by 投融在线 on 16/3/1.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "NewMyProjectModel.h"
#import <objc/runtime.h>



@implementation NewMyProjectModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        unsigned int outCount = 0 ;
        
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
        for (const Ivar *p = ivars; p < ivars + outCount; ++p)
        {
            Ivar const ivar = *p;
            
            //　获取变量名
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
            // 比如 @property(retain) NSString *abc;则 key == _abc;
            
            //　获取变量值
            //            id value = [self valueForKey:key];
            
            id value = [aDecoder decodeObjectForKey:key];
            if (value != nil) {
                [self setValue:value forKey:key];
            }
            
            //            [aCoder encodeObject:value forKey:key];
            //　取得变量类型
            // 通过 type[0]可以判断其具体的内置类型
            //        const char *type = ivar_getTypeEncoding(ivar);
            
        }
        
        //        _type = [aDecoder decodeObjectForKey:TypeKey];
        //        _yearIntroduced = [aDecoder decodeObjectForKey:YearKey];
        //        _introPrice = [aDecoder decodeObjectForKey:PriceKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int outCount = 0 ;
    
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + outCount; ++p)
    {
        Ivar const ivar = *p;
        
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如 @property(retain) NSString *abc;则 key == _abc;
        
        //　获取变量值
        id value = [self valueForKey:key];
        
        [aCoder encodeObject:value forKey:key];
        //　取得变量类型
        // 通过 type[0]可以判断其具体的内置类型
        //        const char *type = ivar_getTypeEncoding(ivar);
        
    }
}
+ (NSDictionary *)objectClassInArray
{
    return @{@"teamList":[TeamList class],@"dynamicList":[DynamicList class]};
}

@end

@implementation TeamList

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        unsigned int outCount = 0 ;
        
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
        for (const Ivar *p = ivars; p < ivars + outCount; ++p)
        {
            Ivar const ivar = *p;
            
            //　获取变量名
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
            // 比如 @property(retain) NSString *abc;则 key == _abc;
            
            //　获取变量值
            //            id value = [self valueForKey:key];
            
            id value = [aDecoder decodeObjectForKey:key];
            if (value != nil) {
                [self setValue:value forKey:key];
            }
            
            //            [aCoder encodeObject:value forKey:key];
            //　取得变量类型
            // 通过 type[0]可以判断其具体的内置类型
            //        const char *type = ivar_getTypeEncoding(ivar);
            
        }
        
        //        _type = [aDecoder decodeObjectForKey:TypeKey];
        //        _yearIntroduced = [aDecoder decodeObjectForKey:YearKey];
        //        _introPrice = [aDecoder decodeObjectForKey:PriceKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int outCount = 0 ;
    
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + outCount; ++p)
    {
        Ivar const ivar = *p;
        
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如 @property(retain) NSString *abc;则 key == _abc;
        
        //　获取变量值
        id value = [self valueForKey:key];
        
        [aCoder encodeObject:value forKey:key];
        //　取得变量类型
        // 通过 type[0]可以判断其具体的内置类型
        //        const char *type = ivar_getTypeEncoding(ivar);
        
    }
}
@end

@implementation DynamicList

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        unsigned int outCount = 0 ;
        
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
        for (const Ivar *p = ivars; p < ivars + outCount; ++p)
        {
            Ivar const ivar = *p;
            
            //　获取变量名
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
            // 比如 @property(retain) NSString *abc;则 key == _abc;
            
            //　获取变量值
            //            id value = [self valueForKey:key];
            
            id value = [aDecoder decodeObjectForKey:key];
            if (value != nil) {
                [self setValue:value forKey:key];
            }
            
            //            [aCoder encodeObject:value forKey:key];
            //　取得变量类型
            // 通过 type[0]可以判断其具体的内置类型
            //        const char *type = ivar_getTypeEncoding(ivar);
            
        }
        
        //        _type = [aDecoder decodeObjectForKey:TypeKey];
        //        _yearIntroduced = [aDecoder decodeObjectForKey:YearKey];
        //        _introPrice = [aDecoder decodeObjectForKey:PriceKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int outCount = 0 ;
    
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + outCount; ++p)
    {
        Ivar const ivar = *p;
        
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如 @property(retain) NSString *abc;则 key == _abc;
        
        //　获取变量值
        id value = [self valueForKey:key];
        
        [aCoder encodeObject:value forKey:key];
        //　取得变量类型
        // 通过 type[0]可以判断其具体的内置类型
        //        const char *type = ivar_getTypeEncoding(ivar);
        
    }
}

@end

@implementation ProjectHighlight
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        unsigned int outCount = 0 ;
        
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
        for (const Ivar *p = ivars; p < ivars + outCount; ++p)
        {
            Ivar const ivar = *p;
            
            //　获取变量名
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
            // 比如 @property(retain) NSString *abc;则 key == _abc;
            
            //　获取变量值
            //            id value = [self valueForKey:key];
            
            id value = [aDecoder decodeObjectForKey:key];
            if (value != nil) {
                [self setValue:value forKey:key];
            }
            
            //            [aCoder encodeObject:value forKey:key];
            //　取得变量类型
            // 通过 type[0]可以判断其具体的内置类型
            //        const char *type = ivar_getTypeEncoding(ivar);
            
        }
        
        //        _type = [aDecoder decodeObjectForKey:TypeKey];
        //        _yearIntroduced = [aDecoder decodeObjectForKey:YearKey];
        //        _introPrice = [aDecoder decodeObjectForKey:PriceKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int outCount = 0 ;
    
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + outCount; ++p)
    {
        Ivar const ivar = *p;
        
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如 @property(retain) NSString *abc;则 key == _abc;
        
        //　获取变量值
        id value = [self valueForKey:key];
        
        [aCoder encodeObject:value forKey:key];
        //　取得变量类型
        // 通过 type[0]可以判断其具体的内置类型
        //        const char *type = ivar_getTypeEncoding(ivar);
        
    }
}
@end


