//
//  BPTagCollectionLayout.m
//  CollectionView
//
//  Created by fujin on 16/1/12.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import "BPTagCollectionLayout.h"

@interface BPTagCollectionLayout ()
@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, assign) NSInteger count;

// arrays to keep track of insert, delete index paths
@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertIndexPaths;
@end

@implementation BPTagCollectionLayout
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.endPoint = CGPointZero;
    //获取item的UICollectionViewLayoutAttributes
    _count = [self.collectionView numberOfItemsInSection:0];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGSize)collectionViewContentSize
{
    CGSize contentSize;
    contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), self.endPoint.y);
    return contentSize;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = 0.0;
    if ([self.delegate collectionView:self.collectionView layout:self widthAtIndexPath:indexPath]) {
        width = [self.delegate collectionView:self.collectionView layout:self widthAtIndexPath:indexPath];
    }
    CGFloat heigh = self.itemHeigh;
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    
    CGFloat judge = self.endPoint.x + width + self.itemSpacing + self.sectionInset.right;
    //大于就换行
    if (judge > CGRectGetWidth(self.collectionView.frame)) {
        x = self.sectionInset.left;
        y = self.endPoint.y + self.lineSpacing;
    }else{
        if (indexPath.item == 0) {
            x = self.sectionInset.left;
            y = self.sectionInset.top;
        }else{
            x = self.endPoint.x + self.itemSpacing;
            y = self.endPoint.y - heigh;
        }
       
    }
    //更新结束位置
    self.endPoint = CGPointMake(x + width, y + heigh);
    
    
    attr.frame = CGRectMake(x, y, width, heigh);
    return attr;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray * attrsArray = [NSMutableArray array];
  
    for (NSInteger j = 0; j < _count; j++) {
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:0]];
        [attrsArray addObject:attrs];
    }
    return  attrsArray;
}

#pragma mark  ---------  加入删除和添加的动画
- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    // Keep track of insert and delete index paths
    [super prepareForCollectionViewUpdates:updateItems];
    
    self.deleteIndexPaths = [NSMutableArray array];
    self.insertIndexPaths = [NSMutableArray array];
    
    for (UICollectionViewUpdateItem *update in updateItems)
    {
        if (update.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
        }
    }
}

- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    // release the insert and delete index paths
    self.deleteIndexPaths = nil;
    self.insertIndexPaths = nil;
}

// all visible cells Appearing
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // Must call super
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if ([self.insertIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on inserted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    }
    
    return attributes;
}


// all visible cells Disappearing
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // So far, calling super hasn't been strictly necessary here, but leaving it in
    // for good measure
    
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    if ([self.deleteIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on deleted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    }
    
    return attributes;
}

@end
