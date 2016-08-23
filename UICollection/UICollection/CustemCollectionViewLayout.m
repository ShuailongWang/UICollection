//
//  CustemCollectionViewLayout.m
//  UICollection
//
//  Created by czbk on 16/8/23.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "CustemCollectionViewLayout.h"

@implementation CustemCollectionViewLayout


-(void)prepareLayout {
    [super prepareLayout];
    
    
}

// 初始状态
-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    //新的 cells 从屏幕底部发射并且旋转飞到对应位置
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    
    attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
    attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
    
    return attr;
}

// 终结状态
- (nullable UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attr.alpha = 0.0f;
    
    return attr;
}
@end
