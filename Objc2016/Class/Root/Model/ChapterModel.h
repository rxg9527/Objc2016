//
//  ChapterModel.h
//  CoreAnimation
//
//  Created by Yuen on 16/8/31.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SectionModel;

@interface ChapterModel : NSObject

@property (nonatomic, copy) NSString *chapterTitle;
@property (nonatomic, strong) NSArray<SectionModel *> *content;

@end
