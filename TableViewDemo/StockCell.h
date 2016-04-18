//
//  StockCell.h
//  TableViewDemo
//
//  Created by sys on 16/4/18.
//  Copyright © 2016年 sys.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SysScrollView.h"

@protocol runManManProtocol <NSObject>

- (void)runManManRunning:(CGPoint)point;

@end

@interface StockCell : UITableViewCell

@property(nonatomic, weak)id<runManManProtocol>runManDelegate;

- (void)setRunManParame:(NSArray *)contentArr;

@property(nonatomic, strong)SysScrollView *sysScrollView;

@end
