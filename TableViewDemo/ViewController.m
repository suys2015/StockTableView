//
//  ViewController.m
//  TableViewDemo
//
//  Created by sys on 16/4/18.
//  Copyright © 2016年 sys.com. All rights reserved.
//

#import "ViewController.h"
#import "StockCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, runManManProtocol, runManProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property (nonatomic, strong)NSArray *dataSourceArr;

@property (weak, nonatomic) IBOutlet UIView *headView;

@property (nonatomic, strong)SysScrollView *sysScrollView;

@end

@implementation ViewController

static NSString *cellStr = @"StockCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tb registerNib:[UINib nibWithNibName:cellStr bundle:nil] forCellReuseIdentifier:cellStr];
    
    _dataSourceArr = @[@[@"18.71", @"+0.99", @"1.76", @"4", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"12.31", @"-0.99", @"3.75", @"3", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"11.21", @"+1.59", @"14.10", @"3", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"10.11", @"-3.19", @"12.20", @"2", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"19.72", @"+0.99", @"11.80", @"4", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"121.43",@"+5.29", @"14.40", @"6", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"11.39", @"-1.93", @"13.50", @"8", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"12.53", @"+1.32", @"1.76", @"2", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"19.83", @"+3.24", @"13.30", @"5", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"13.22", @"-1.62", @"1.74", @"2", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"15.89", @"-3.45", @"11.30", @"7", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"12.56", @"+0.78", @"11.20", @"4", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"],
                       @[@"14.22", @"-0.09", @"13.70", @"6", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%", @"7.03%"]];
    
    _sysScrollView = [[SysScrollView alloc] initWithFrame:CGRectMake(90, 0, self.view.frame.size.width - 90, _headView.frame.size.height) withContentArray:@[@"最新", @"涨幅", @"涨跌额", @"换手", @"量比", @"涨速", @"市盈", @"市值", @"总市值", @"总手"]];
    _sysScrollView.runDelegate = self;
    [_headView addSubview:_sysScrollView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StockCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    cell.runManDelegate = self;
    [cell setRunManParame:_dataSourceArr[indexPath.row]];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point =  CGPointFromString([[NSUserDefaults standardUserDefaults] objectForKey:@"contentOffset"]);
    for (int i =0 ; i < _dataSourceArr.count; i++) {
        StockCell *cell = [self.tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell.sysScrollView.sysScrollView setContentOffset:point animated:NO];
    }
     [_sysScrollView.sysScrollView setContentOffset:point animated:NO];
}

/**
 *  1.一次刷新当前的所有cell的contentsize
    2.刷新可视范围内的cell的contentSize.layoutside的时候设置下一个cell的contentsize
 */
- (void)runManManRunning:(CGPoint)point
{
    for (int i =0 ; i < _dataSourceArr.count; i++) {
        StockCell *cell = [self.tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell.sysScrollView.sysScrollView setContentOffset:point];
    }
    [_sysScrollView.sysScrollView setContentOffset:point];
}

- (void)runManRunning:(CGPoint)point
{
    for (int i =0 ; i < _dataSourceArr.count; i++) {
        StockCell *cell = [self.tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell.sysScrollView.sysScrollView setContentOffset:point ];
    }
     [_sysScrollView.sysScrollView setContentOffset:point];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
