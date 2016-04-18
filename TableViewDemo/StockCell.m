//
//  StockCell.m
//  TableViewDemo
//
//  Created by sys on 16/4/18.
//  Copyright © 2016年 sys.com. All rights reserved.
//

#import "StockCell.h"


@interface StockCell()<UIScrollViewDelegate,runManProtocol>
@property(nonatomic, strong)NSArray *contentArr;
@end

@implementation StockCell

- (void)awakeFromNib {
    _sysScrollView = [[SysScrollView  alloc] initWithFrame:CGRectMake(90, 0, self.contentView.frame.size.width - 90, self.contentView.frame.size.height) withContentArray:@[@"- -", @"- -", @"- -", @"- -", @"- -", @"- -", @"- -", @"- -", @"- -", @"- -"]];
    _sysScrollView.runDelegate = self;
    [self.contentView addSubview:_sysScrollView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)runManRunning:(CGPoint)point
{
    if(_runManDelegate && [_runManDelegate respondsToSelector:@selector(runManManRunning:)]){
        [_runManDelegate runManManRunning:point];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
     CGPoint point =  CGPointFromString([[NSUserDefaults standardUserDefaults] objectForKey:@"contentOffset"]);
    [self.sysScrollView.sysScrollView setContentOffset:point animated:NO];

}


- (void)setRunManParame:(NSArray *)contentArr
{
    [_sysScrollView upScollViewContent:contentArr];
    
    _contentArr = contentArr;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
