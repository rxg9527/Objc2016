//
//  JJViewController.m
//  JJKit
//
//  Created by 庄BB的MacBook on 16/8/10.
//  Copyright © 2016年 BBFC. All rights reserved.
//

#import "JJViewController.h"

@implementation JJViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //!!!:UINavigationBar的setBackgroundImage:forBarPosition:barMetrics:会导致self.automaticallyAdjustsScrollViewInsets = NO失效，而setBarTintColor:不会
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]
//                                                 forBarPosition:UIBarPositionAny
//                                                     barMetrics:UIBarMetricsDefault];

    if (self.navigationController.viewControllers.count == 1) {
//        self.navigationController.navigationBarHidden = YES;
        [self.tabBarController setHidesBottomBarWhenPushed:NO];
    }
    else {
//        self.navigationController.navigationBarHidden = NO;
        [self.tabBarController setHidesBottomBarWhenPushed:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.navigationController.navigationBar.barTintColor = RGBA(248, 248, 248, 0.3);
    
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"base_back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"base_back"];
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithWhite:0.11 alpha:1];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    if (self.parentViewController.childViewControllers.count > 1) {
//        [self setLeftButton:nil Image:nil];
    } else {
        if (self.presentingViewController) {
//            [self setLeftButton:nil Image:@"back"];
        }
    }
//    self.view.backgroundColor = ERPControllerBackgroundColor;
    self.navigationController.navigationBar.titleTextAttributes = [self getNavigationTitleTextAttributes];
}

//导航栏左边按钮
- (void)setLeftButton:(NSString *)title Image:(NSString *)image
{
    UIButton *btnBack = [[UIButton alloc] init];
    btnBack.backgroundColor = [UIColor clearColor];
    btnBack.frame = CGRectMake(0, 0, 60, 44);
    [btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    if (title) {
        btnBack.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [btnBack setTitle:title forState:UIControlStateNormal];
        btnBack.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [btnBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else {
        btnBack.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);

        if (image) {
            [btnBack setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        }
        else {
            [btnBack setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        }
    }
    [btnBack addTarget:self action:@selector(leftReturn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                             target:nil
                             action:nil];
    negativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[ negativeSpacer, backItem ];
}

//导航栏左边按钮事件
- (void)leftReturn:(UIButton *)sender
{
    if (![self isMemberOfClass:[JJViewController class]]) {
        if (self.parentViewController.childViewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}

- (NSDictionary *)getNavigationTitleTextAttributes
{
    return @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.11 alpha:1], NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
}

#pragma mark - nav buttonitem
- (void)setLeftButton:(NSString *)buttonTitle titleImage:(NSString *)TitleImage action:(SEL)action
{
    CGSize size = [buttonTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    UIImage *image = [UIImage imageNamed:TitleImage];
    UIImage *highlightedImage = [UIImage imageNamed:TitleImage];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setFrame:CGRectMake(0, 0, MAX((size.width + 30), 40), MAX(30, size.height))];
    [button setBackgroundImage:[highlightedImage stretchableImageWithLeftCapWidth:20 topCapHeight:15] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[image stretchableImageWithLeftCapWidth:20 topCapHeight:15] forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateHighlighted];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];

    [button setTitleColor:[UIColor colorWithWhite:0.11 alpha:1] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                             target:nil
                             action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[ negativeSpacer, backItem ];
}
- (UIButton *)setRightButton:(NSString *)buttonTitle titleImage:(NSString *)TitleImage action:(SEL)action
{
    CGSize size = [buttonTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    UIImage *image = [UIImage imageNamed:TitleImage];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setFrame:CGRectMake(0, 0, MAX((size.width + 30), 40), MAX(30, size.height))];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[image stretchableImageWithLeftCapWidth:20 topCapHeight:15] forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateHighlighted];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];

    [button setTitleColor:[UIColor colorWithWhite:0.11 alpha:1] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                             target:nil
                             action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[ negativeSpacer, backItem ];
    return button;
}

- (UIButton *)addRightButton:(NSString *)buttonTitle titleImage:(NSString *)TitleImage action:(SEL)action {
    CGSize size = [buttonTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    UIImage *image = [UIImage imageNamed:TitleImage];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setFrame:CGRectMake(0, 0, MAX((size.width + 30), 40), MAX(30, size.height))];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[image stretchableImageWithLeftCapWidth:20 topCapHeight:15] forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateHighlighted];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitleColor:[UIColor colorWithWhite:0.11 alpha:1] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil
                                       action:nil];
    negativeSpacer.width = -10;
    NSMutableArray *array = self.navigationItem.rightBarButtonItems.mutableCopy;
    if (!array) {
        array = @[].mutableCopy;
    }
    [array addObject:negativeSpacer];
    [array addObject:backItem];
    self.navigationItem.rightBarButtonItems = array;
    return button;
}

- (void)setNavigationBarBackGroundWithImage:(UIImage *)image
{
    [self.navigationController.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
}

- (void)setNavigationBarBackGroundWithColor:(UIColor *)color
{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarPosition:UIBarPositionAny
//                                                     barMetrics:UIBarMetricsDefault];
}

@end
