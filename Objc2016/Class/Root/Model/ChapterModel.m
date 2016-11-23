//
//  ChapterModel.m
//  CoreAnimation
//
//  Created by Yuen on 16/8/31.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ChapterModel.h"
#import "SectionModel.h"

@implementation ChapterModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"content" : @"Content",
             @"chapterTitle" : @"Chapter"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"content" : [SectionModel class],
             };
}

@end
