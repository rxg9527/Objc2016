//
//  XGPredicateVC.m
//  Objc2016
//
//  Created by Yuen on 2016/11/23.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "XGPredicateVC.h"


#pragma mark - Person Model
@interface Person : NSObject
@property NSString *firstName;
@property NSString *lastName;
@property NSNumber *age;
@end

@implementation Person

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end


@interface XGPredicateVC ()


@end


@implementation XGPredicateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"NSPredicate 谓词";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self test1];
        [self testSubstitutions];
    });
}

- (void)test1 {
    NSArray *firstNames = @[ @"Alice", @"Bob", @"Charlie", @"Quentin" ];
    NSArray *lastNames = @[ @"Smith", @"Jones", @"Smith", @"Alberts" ];
    NSArray *ages = @[ @24, @27, @33, @31 ];
    
    NSMutableArray *people = [NSMutableArray array];
    [firstNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Person *person = [[Person alloc] init];
        person.firstName = firstNames[idx];
        person.lastName = lastNames[idx];
        person.age = ages[idx];
        [people addObject:person];
    }];
    
    NSPredicate *bobPredicate = [NSPredicate predicateWithFormat:@"firstName = 'Bob'"];
    NSPredicate *smithPredicate = [NSPredicate predicateWithFormat:@"lastName = %@", @"Smith"];
    NSPredicate *thirtiesPredicate = [NSPredicate predicateWithFormat:@"age >= 30"];
    
    // ["Bob Jones"]
    NSLog(@"Bobs: %@", [people filteredArrayUsingPredicate:bobPredicate]);
    
    // ["Alice Smith", "Charlie Smith"]
    NSLog(@"Smiths: %@", [people filteredArrayUsingPredicate:smithPredicate]);
    
    // ["Charlie Smith", "Quentin Alberts"]
    NSLog(@"30's: %@", [people filteredArrayUsingPredicate:thirtiesPredicate]);
}

/*
 替换
 */
- (void)testSubstitutions {
    NSArray *firstNames = @[ @"Alice", @"Bob", @"Charlie", @"Quentin" ];
    NSArray *lastNames = @[ @"Smith", @"Jones", @"Smith", @"Alberts" ];
    NSArray *ages = @[ @24, @27, @33, @31 ];
    
    NSMutableArray *people = [NSMutableArray array];
    [firstNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Person *person = [[Person alloc] init];
        person.firstName = firstNames[idx];
        person.lastName = lastNames[idx];
        person.age = ages[idx];
        [people addObject:person];
    }];

    /*
     1、
     %@是对值为字符串，数字或者日期的对象的替换值。
     %K是key path的替换值。
     */
    NSPredicate *ageIs33Predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"age", @33];
    
    // ["Charlie Smith"]
    NSLog(@"Age 33: %@", [people filteredArrayUsingPredicate:ageIs33Predicate]);

    /*
     2
     $VARIABLE_NAME是可以被NSPredicate -predicateWithSubstitutionVariables:替换的值。
     Objective-C
     */
    NSPredicate *namesBeginningWithLetterPredicate = [NSPredicate predicateWithFormat:@"(firstName BEGINSWITH[cd] $letter) OR (lastName BEGINSWITH[cd] $letter)"];
    
    // ["Alice Smith", "Quentin Alberts"]
    NSLog(@"'A' Names: %@", [people filteredArrayUsingPredicate:[namesBeginningWithLetterPredicate predicateWithSubstitutionVariables:@{@"letter": @"A"}]]);

}

@end
