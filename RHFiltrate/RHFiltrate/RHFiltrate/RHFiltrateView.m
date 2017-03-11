//
//  RHFiltrateView.m
//  MCSchool
//
//  Created by 郭人豪 on 2016/12/24.
//  Copyright © 2016年 Abner_G. All rights reserved.
//

#import "RHFiltrateView.h"
#import "RHFiltrateHeaderView.h"
#import "RHFiltrateFooterView.h"
#import "RHFiltrateCell.h"
#import "RHCollectionViewFlowLayout.h"
#import "RHHelper.h"

#define Cell_Filtrate              @"Cell_Filtrate"
#define Collection_FiltrateHeader  @"Collection_FiltrateHeader"
#define Collection_FiltrateFooter  @"Collection_FiltrateFooter"

#define MarginX      10    //item X间隔
#define MarginY      15    //item Y间隔
#define ItemHeight   30    //item 高度
#define ItemWidth    30    //item 追加宽度
@interface RHFiltrateView () <UICollectionViewDelegate, UICollectionViewDataSource, RHCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) NSArray * itemArr;
@property (nonatomic, strong) NSMutableArray * dataArr;
@end
@implementation RHFiltrateView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles items:(NSArray<NSArray *> *)items {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _titleArr = [NSArray arrayWithArray:titles];
        _itemArr = [NSArray arrayWithArray:items];
        [self loadData];
        [self addSubviews];
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles items:(NSArray<NSArray *> *)items {
    
    self = [super init];
    
    if (self) {
        
        _titleArr = [NSArray arrayWithArray:titles];
        _itemArr = [NSArray arrayWithArray:items];
        [self loadData];
        [self addSubviews];
    }
    return self;
}

#pragma mark - load data

- (void)loadData {
    
    for (int i = 0; i < _itemArr.count; i++) {
        
        NSMutableArray * array = [[NSMutableArray alloc] init];
        NSArray * arr = _itemArr[i];
        
        for (int j = 0; j < arr.count; j++) {
            
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:arr[j] forKey:@"title"];
            if (j == 0) {
                
                [dic setObject:@YES forKey:@"isSelected"];
            } else {
                
                [dic setObject:@NO forKey:@"isSelected"];
            }
            [array addObject:dic];
        }
        [self.dataArr addObject:array];
    }
}

#pragma mark - add subviews

- (void)addSubviews {
    
    [self addSubview:self.collectionView];
}

#pragma mark - layout subviews

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _collectionView.frame = self.bounds;
    [_collectionView reloadData];
}


#pragma mark - collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return _titleArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_itemArr[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RHFiltrateCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Filtrate forIndexPath:indexPath];
    if (indexPath.row < [self.dataArr[indexPath.section] count]) {
        
        NSDictionary * dic = _dataArr[indexPath.section][indexPath.row];
        [cell configCellWithData:dic];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.dataArr[indexPath.section]];
    
    for (int i = 0; i < array.count; i++) {
        
        NSMutableDictionary * dic = array[i];
        if (i == indexPath.row) {
            
            [dic setObject:@YES forKey:@"isSelected"];
        } else {
            
            [dic setObject:@NO forKey:@"isSelected"];
        }
        [array replaceObjectAtIndex:i withObject:dic];
    }
    [_dataArr replaceObjectAtIndex:indexPath.section withObject:array];
    [_collectionView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(filtrateView:didSelectAtIndexPath:)]) {
        
        [self.delegate filtrateView:self didSelectAtIndexPath:indexPath];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        RHFiltrateHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:Collection_FiltrateHeader forIndexPath:indexPath];
        headerView.headerTitle = _titleArr[indexPath.section];
        return headerView;
    } else {
        
        RHFiltrateFooterView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:Collection_FiltrateFooter forIndexPath:indexPath];
        return footerView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    float width = [RHHelper getWidthByText:_itemArr[indexPath.section][indexPath.row] font:H15] + ItemWidth;
    return CGSizeMake(width, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(self.bounds.size.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(self.bounds.size.width, 1);
}

#pragma mark - setter and getter

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        RHCollectionViewFlowLayout * flowLayout = [[RHCollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = MarginY;
        flowLayout.minimumInteritemSpacing = MarginX;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 15, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
//        _collectionView.bounces = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[RHFiltrateCell class] forCellWithReuseIdentifier:Cell_Filtrate];
        [_collectionView registerClass:[RHFiltrateHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:Collection_FiltrateHeader];
        [_collectionView registerClass:[RHFiltrateFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:Collection_FiltrateFooter];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end
