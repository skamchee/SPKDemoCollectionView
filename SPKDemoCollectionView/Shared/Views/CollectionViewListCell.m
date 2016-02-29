//
//  CollectionViewListCell.m
//  SPKDemoCollectionView
//
//  Created by Spencer Kamchee on 2/25/16.
//  Copyright © 2016 Spencer Kamchee. All rights reserved.
//

#import "CollectionViewListCell.h"

static CGSize _extraMargins = {0,0};

@implementation CollectionViewListCell

//- (CGSize)intrinsicContentSize
//{
//    CGSize size = [self.titleLabel intrinsicContentSize];
//    size.width += [self.detailLabel intrinsicContentSize].width;
//    size.height += [self.detailLabel intrinsicContentSize].height;
//    
//    
//    if (CGSizeEqualToSize(_extraMargins, CGSizeZero))
//    {
//        // quick and dirty: get extra margins from constraints
//        for (NSLayoutConstraint *constraint in self.constraints)
//        {
//            if (constraint.secondAttribute == NSLayoutAttributeBottomMargin || constraint.secondAttribute == NSLayoutAttributeTopMargin)
//            {
//                // vertical spacer
//                _extraMargins.height += [constraint constant];
//            }
//            else if (constraint.secondAttribute == NSLayoutAttributeLeadingMargin || constraint.secondAttribute == NSLayoutAttributeTrailingMargin)
//            {
//                // horizontal spacer
//                _extraMargins.width += [constraint constant];
//            }
//        }
//    }
//    
//    // add to intrinsic content size of label
//    size.width += _extraMargins.width;
//    size.height += _extraMargins.height;
//    
//    return size;
//}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.layoutMargins = UIEdgeInsetsMake(5,5,5,5);
}

@end
