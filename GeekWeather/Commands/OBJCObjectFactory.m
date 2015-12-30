//
//  OBJCObjectFactory.m
//  GeekWeather
//
//  Created by 梅俊 on 15/12/30.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

#import "OBJCObjectFactory.h"

@implementation OBJCObjectFactory

+ (id)create:(NSString *)className
{
    return [[NSClassFromString(className) alloc] init];
}

@end
