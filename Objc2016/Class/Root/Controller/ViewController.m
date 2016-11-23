//
//  ViewController.m
//  CoreAnimation
//
//  Created by Yuen on 16/8/31.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"
#import "ChapterModel.h"
#import "YYModel.h"
#import "SectionModel.h"
#import "XGCell.h"

static NSString *const kReuseCellID = @"XGCell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<ChapterModel *> *dataSourceArray;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"目录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    self.dataSourceArray = [NSArray yy_modelArrayWithClass:ChapterModel.class json:[[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"]]];
    [self.tableView registerClass:[XGCell class] forCellReuseIdentifier:kReuseCellID];
}

#pragma mark- UITableViewDataSource
// 返回有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArray.count;
}

// 返回每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray[section].content.count;
}

// 每一个cell的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XGCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass(XGCell.class) forIndexPath:indexPath];
    SectionModel *model = self.dataSourceArray[indexPath.section].content[indexPath.row];
    cell.textLabel.text = model.sectionTitle;
    cell.detailTextLabel.text = model.sectionTitle;
    cell.imageView.backgroundColor = [UIColor blueColor];
    //右边的accessory
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

// 每个section的header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ChapterModel *model = self.dataSourceArray[section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    label.text = model.chapterTitle;

    return label;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

//点击每一行的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第%ld组第%ld行", indexPath.section, indexPath.row);
}

@end
