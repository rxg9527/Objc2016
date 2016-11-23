//
//  JJViewController.h
//  JJKit
//
//  Created by 庄BB的MacBook on 16/8/10.
//  Copyright © 2016年 BBFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJViewController : UIViewController <UIGestureRecognizerDelegate>

- (void)setLeftButton:(NSString *)buttonTitle titleImage:(NSString *)TitleImage action:(SEL)action;

//自定义NavgationBar右侧按钮
- (UIButton *)setRightButton:(NSString *)buttonTitle titleImage:(NSString *)TitleImage action:(SEL)action;
// 可重复添加
- (UIButton *)addRightButton:(NSString *)buttonTitle titleImage:(NSString *)TitleImage action:(SEL)action;

//导航栏左边按钮 可重写事件 返回按钮
- (void)leftReturn:(UIButton *)sender;

- (void)setNavigationBarBackGroundWithImage:(UIImage *)image;

- (void)setNavigationBarBackGroundWithColor:(UIColor *)color;

@end
