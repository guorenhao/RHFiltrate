//
//  ViewController.m
//  RHFiltrate
//
//  Created by 郭人豪 on 2017/3/4.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "ViewController.h"
#import "RHFiltrateView.h"

@interface ViewController () <RHFiltrateViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
}


- (void)test {
    
    self.view.backgroundColor = Color_Random;
    RHFiltrateView * filtrate = [[RHFiltrateView alloc] initWithTitles:@[@"123", @"一二三", @"价格", @"地区"] items:@[@[@"全部", @"123", @"234", @"345", @"456", @"567", @"678", @"789"], @[@"全部", @"一二三", @"二三四", @"三四五", @"四五六", @"五六七", @"六七八"], @[@"全部", @"0-100元", @"101-500元", @"501-1000元", @"1001-2000元", @"2001-5000元", @"5000元以上"], @[@"全国", @"北京", @"上海", @"郑州", @"石家庄", @"天津", @"深圳"]]];
    filtrate.frame = CGRectMake(0, 64, 320, 400);
    filtrate.delegate = self;
    
    [self.view addSubview:filtrate];
}

#pragma mark - filetrate delegate

- (void)filtrateView:(RHFiltrateView *)filtrateView didSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", indexPath);
}


@end
