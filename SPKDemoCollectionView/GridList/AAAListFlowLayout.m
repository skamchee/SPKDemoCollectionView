//
//  AAAListFlowLayout.m
//  SPKDemoCollectionView
//
//  Created by Spencer Kamchee on 2/24/16.
//  Copyright © 2016 Spencer Kamchee. All rights reserved.
//

#import "AAAListFlowLayout.h"

@implementation AAAListFlowLayout

-(CGFloat)itemHeight{
    return 100;
}

-(CGFloat)itemWidth{
    return CGRectGetWidth(self.collectionView.frame);
}

-(CGSize)itemSize{
    return CGSizeMake([self itemWidth],[self itemHeight]);
}

-(void)setItemSize{
    self.itemSize = CGSizeMake([self itemWidth],[self itemHeight]);
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
    return self.collectionView.contentOffset;
}

@end
