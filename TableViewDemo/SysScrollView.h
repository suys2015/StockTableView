//
//  SysScrollView.h
//  TableViewDemo
//
//  Created by sys on 16/4/18.
//  Copyright © 2016年 sys.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol runManProtocol <NSObject>

- (void)runManRunning:(CGPoint)point;

@end

@interface SysScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *sysScrollView;

@property(nonatomic, weak)id<runManProtocol>runDelegate;

- (instancetype)initWithFrame:(CGRect)frame
             withContentArray:(NSArray *)contentArr;

- (void)upScollViewContent:(NSArray *)contentArr;

@end
