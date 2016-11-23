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
//        [self test1];
//        [self testSubstitutions];
        
        //熟悉Predicate
        //[self testPredicateDefinition];
        
        //学习Predicate的比较功能
        //[self testPredicateComparation];
        
        //学习Predicate范围运算功能
        [self testPredicateRange];
        
        //学习Predicate 与自身相比的功能
        //[self testPredicateComparationToSelf];
        
        //学习Predicate 字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
//        [self testPredicateRelateToNSString];
        
        //学习Predicate 的通配
//        [self testPredicateWildcard];

    });
}

#pragma mark - nshipster
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

#pragma mark - https://github.com/jiulin/NSPredicateDemo
#pragma mark Predicate 的通配
- (void)testPredicateWildcard{
    /*
     (5)通配符：LIKE
     例：@"name LIKE[cd] '*er*'"
     //  *代表通配符,Like也接受[cd].
     @"name LIKE[cd] '???er*'"
     */
    NSArray *placeArray = [NSArray arrayWithObjects:@"Shanghai",@"Hangzhou",@"Beijing",@"Macao",@"Taishan", nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF  like '*ai*' "];
    
    NSArray *tempArray = [placeArray filteredArrayUsingPredicate:predicate];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj == %@",obj);
    }];
    
}

#pragma mark Predicate 字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
- (void)testPredicateRelateToNSString{
    /*
     (4)字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
     例：@"name CONTAIN[cd] 'ang'"   //包含某个字符串
     @"name BEGINSWITH[c] 'sh'"     //以某个字符串开头
     @"name ENDSWITH[d] 'ang'"      //以某个字符串结束
     注:[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。
     */
    NSArray *placeArray = [NSArray arrayWithObjects:@"Shanghai",@"Hangzhou",@"Beijing",@"Macao",@"Taishan", nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS [cd] 'an' "];
    // NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF Beginswith [cd] 'sh' "];
    
    NSArray *tempArray = [placeArray filteredArrayUsingPredicate:predicate];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj == %@",obj);
    }];
    
}

#pragma  mark Predicate 与自身相比的功能
- (void)testPredicateComparationToSelf{
    /*
     (3)字符串本身:SELF
     例：@“SELF == ‘APPLE’"
     */
    NSArray *placeArray = [NSArray arrayWithObjects:@"Shanghai",@"Hangzhou",@"Beijing",@"Macao",@"Taishan", nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == 'Beijing'"];
    NSArray *tempArray = [placeArray filteredArrayUsingPredicate:predicate];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj == %@",obj);
    }];
    
}

#pragma mark Predicate范围运算功能
- (void)testPredicateRange{
    /*
     (2)范围运算符：IN、BETWEEN
     {}里面有的数据才会显示IN   范围：BETWEEN都是可以的！IN精确查找，BETWEEN模糊查找
     例：@"number BETWEEN {1,5}"
     @"address IN {'shanghai','beijing'}"
     */
    NSArray *array = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@2,@6, nil];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF in {2,5}"]; 找到 in 的意思是array中{2,5}的元素
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BETWEEN {2,5}"];
    NSArray *fliterArray = [array filteredArrayUsingPredicate:predicate];
    [fliterArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"fliterArray = %@",obj);
    }];
}

#pragma mark 测试Predicate的比较功能
- (void)testPredicateComparation{
    /*
     (1)比较运算符>,<,==,>=,<=,!=
     可用于数值及字符串
     例：@"number > 100"
     */
    NSArray *array = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@2,@6, nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF >4"];
    NSArray *fliterArray = [array filteredArrayUsingPredicate:predicate];
    [fliterArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"fliterArray = %@",obj);
    }];
}

#pragma mark 熟悉Predicate
- (void)testPredicateDefinition{
    NSArray *array = [[NSArray alloc]initWithObjects:@"beijing",@"shanghai",@"guangzou",@"wuhan", nil];;
    //表示在数组里面筛选还有@"be"的字符串
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"be"];
    NSArray *temp = [array filteredArrayUsingPredicate:predicate];
    [temp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"temp = %@",obj);
    }];
    
    /***************************************************************/
    //NSPredicate给我留下最深印象的是两个数组求交集的一个需求，如果按照一般写法，需要2个遍历，但NSArray提供了一个filterUsingPredicate的方法，用了NSPredicate，就可以不用遍历！
    NSArray *array1 = [NSArray arrayWithObjects:@1,@2,@3,@5,@5,@6,@7, nil];
    NSArray *array2 = [NSArray arrayWithObjects:@4,@5, nil];
    // 表示筛选array1在array2中的元素!YES！其中SELF指向filteredArrayUsingPredicate的调用者。
    /*测试方案：
     NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF in %@",array2];
     NSArray *temp1 = [array1 filteredArrayUsingPredicate:predicate1];
     结果：
     2015-11-08 10:55:19.879 NSPredicateDemo[11595:166012] obj ==5
     2015-11-08 10:55:19.879 NSPredicateDemo[11595:166012] obj ==5
     
     NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF  in %@",array1];
     NSArray *temp1 = [array2 filteredArrayUsingPredicate:predicate1];
     结果：
     2015-11-08 10:55:19.879 NSPredicateDemo[11595:166012] obj ==5
     
     */
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF  in %@",array2];
    NSArray *temp1 = [array1 filteredArrayUsingPredicate:predicate1];
    
    [temp1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"temp1 = %@",obj);
    }];
    /*
     2015-11-08 10:55:19.879 NSPredicateDemo[11595:166012] obj ==5
     2015-11-08 10:55:19.879 NSPredicateDemo[11595:166012] obj ==5
     */
}

@end
