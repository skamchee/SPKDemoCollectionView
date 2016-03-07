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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    AAAViewControllerGridList* dataSource = (AAAViewControllerGridList*)self.collectionView.dataSource;
    AAAModelItem* item = [dataSource modelAtIndexPath:indexPath];
    
    CGRect bounds = CGRectMake(0,0,self.collectionView.bounds.size.width,self.collectionView.bounds.size.height);
    CGRect titleRect;
    
    CGFloat fontSize = 18.0;
    titleRect = [item.title boundingRectWithSize:CGSizeMake(bounds.size.width/4, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                         context:nil];
    
    titleRect.size.width = bounds.size.width/4;
    
    //margins
    titleRect.size.height += 10;
    return titleRect.size;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}
@end
