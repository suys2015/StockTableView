//
//  SysScrollView.m
//  TableViewDemo
//
//  Created by sys on 16/4/18.
//  Copyright © 2016年 sys.com. All rights reserved.
//

#import "SysScrollView.h"

#define kLabWidth 85
#define kLabTag 1000

@implementation SysScrollView

- (instancetype)initWithFrame:(CGRect)frame
             withContentArray:(NSArray *)contentArr
{
    self = [super initWithFrame:frame];
    if(self){
        
        if(contentArr.count == 0)
            return self;
        
        self.backgroundColor = [UIColor yellowColor];
        
        _sysScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _sysScrollView.showsVerticalScrollIndicator = NO;
        _sysScrollView.showsHorizontalScrollIndicator = NO;
        _sysScrollView.delegate = self;
        _sysScrollView.canCancelContentTouches = YES;
        [self addSubview:_sysScrollView];
        
        self.sysScrollView.contentSize = CGSizeMake(contentArr.count * kLabWidth, _sysScrollView.frame.size.height);
        
        //重新生成cell的时候需要滚动到之前统一的位置
        CGPoint point =  CGPointFromString([[NSUserDefaults standardUserDefaults] objectForKey:@"contentOffset"]);
        [self.sysScrollView setContentOffset:point animated:NO];
        
        for (int i = 0; i < contentArr.count; i++) {
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(i * kLabWidth, 0, kLabWidth, _sysScrollView.frame.size.height)];
            lab.text = contentArr[i];
            lab.tag = i + kLabTag;
            if(i%2 == 0){
                lab.backgroundColor = [UIColor redColor];
            }
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont systemFontOfSize:15];
            [self.sysScrollView addSubview:lab];

        }
    }
    return self;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_runDelegate && [_runDelegate respondsToSelector:@selector(runManRunning:)]){
        
        [_runDelegate runManRunning:scrollView.contentOffset];
        //记录之前的滚动的位置
        [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGPoint(scrollView.contentOffset) forKey:@"contentOffset"];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate){
        [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGPoint(scrollView.contentOffset) forKey:@"contentOffset"];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGPoint(scrollView.contentOffset) forKey:@"contentOffset"];
}




- (void)upScollViewContent:(NSArray *)contentArr
{
    if(contentArr.count < self.sysScrollView.subviews.count)
        return;
    
    [self.sysScrollView.subviews enumerateObjectsUsingBlock:^(UILabel *lab, NSUInteger idx, BOOL * _Nonnull stop) {
        lab.text = contentArr[idx];
    }];
    
}


@end
