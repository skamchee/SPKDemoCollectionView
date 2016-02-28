//
//  AAAGridFlowLayout.m
//  SPKDemoCollectionView
//
//  Created by Spencer Kamchee on 2/24/16.
//  Copyright © 2016 Spencer Kamchee. All rights reserved.
//

#import "AAAGridFlowLayout.h"

@implementation AAAGridFlowLayout


-(CGFloat)itemHeight{
    return 50;
}

-(CGFloat)itemWidth{
   return (CGRectGetWidth(self.collectionView.frame)/4)-1;
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
