//
//  AAAGridFlowLayout.m
//  SPKDemoCollectionView
//
//  Created by Spencer Kamchee on 2/24/16.
//  Copyright © 2016 Spencer Kamchee. All rights reserved.
//

#import "AAAGridFlowLayout.h"
#import "AAAViewControllerGridList.h"

@implementation AAAGridFlowLayout


-(CGFloat)itemHeight{
    return 50;
}

-(CGFloat)itemWidth{
   return (CGRectGetWidth(self.collectionView.frame)/4)-1;
}

//This size is used if the collection view does not implement collectionView:layout:sizeForItemAtIndexPath:
-(CGSize)itemSize{
    return CGSizeMake([self itemWidth],[self itemHeight]);
}

-(void)setItemSize{
    self.itemSize = CGSizeMake([self itemWidth],[self itemHeight]);
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
    return self.collectionView.contentOffset;
}


//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSMutableArray *layoutAttributes = [NSMutableArray array];
//    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
//    [layoutAttributes addObject:attributes];
//    return layoutAttributes;
//}
//
////Logic for how to layout the cells
//-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    AAAViewControllerGridList* dataSource = (AAAViewControllerGridList*)self.collectionView.dataSource;
//    AAAModelItem* event = [dataSource modelAtIndexPath:indexPath];
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    attributes.frame = [self frameForEvent:event];
//    return attributes;
//}
//
//-(CGRect)frameForEvent:(AAAModelItem*)item{
//    CGRect titleSize = CGRectMake(0, 0, 100, 100);
//    return titleSize;
//}
@end
