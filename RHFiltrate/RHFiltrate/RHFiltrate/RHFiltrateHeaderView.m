//
//  RHFiltrateHeaderView.m
//  MCSchool
//
//  Created by 郭人豪 on 2016/12/24.
//  Copyright © 2016年 Abner_G. All rights reserved.
//

#import "RHFiltrateHeaderView.h"

@interface RHFiltrateHeaderView ()

@property (nonatomic, strong) UILabel * lab_title;
@end
@implementation RHFiltrateHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lab_title];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    
    _lab_title.frame = CGRectMake(15, 0, width - 30, height);
}

- (UILabel *)lab_title {
    
    if (!_lab_title) {
        
        _lab_title = [[UILabel alloc] init];
        _lab_title.textColor = Color_H1;
        _lab_title.font = H16;
    }
    return _lab_title;
}

- (void)setHeaderTitle:(NSString *)headerTitle {
    
    if (headerTitle.length > 0) {
        
        _lab_title.text = headerTitle;
    }
}


@end
