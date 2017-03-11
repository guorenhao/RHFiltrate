//
//  RHFiltrateView.h
//  MCSchool
//
//  Created by 郭人豪 on 2016/12/24.
//  Copyright © 2016年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHFiltrateViewDelegate;
@interface RHFiltrateView : UIView

@property (nonatomic, weak) id<RHFiltrateViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles items:(NSArray<NSArray *> *)items;

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles items:(NSArray<NSArray *> *)items;

@end
@protocol RHFiltrateViewDelegate <NSObject>

@optional
- (void)filtrateView:(RHFiltrateView *)filtrateView didSelectAtIndexPath:(NSIndexPath *)indexPath;

@end
