//
//  AAAListFlowLayout.m
//  SPKDemoCollectionView
//
//  Created by Spencer Kamchee on 2/24/16.
//  Copyright © 2016 Spencer Kamchee. All rights reserved.
//

#import "AAAListFlowLayout.h"
#import "AAAViewControllerGridList.h"

@interface AAAListFlowLayout()

@property (strong,nonatomic)NSMutableArray* layoutAttributes;
@end

@implementation AAAListFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    AAAViewControllerGridList* dataSource = (AAAViewControllerGridList*)self.collectionView.dataSource;
    AAAModelItem* item = [dataSource modelAtIndexPath:indexPath];
    
    CGRect bounds = CGRectMake(0,0,self.collectionView.bounds.size.width,self.collectionView.bounds.size.height);
    CGRect titleRect;
    CGRect detailRect;
    
    CGFloat fontSize = 18.0;
    titleRect = [item.title boundingRectWithSize:CGSizeMake(bounds.size.width-10, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                         context:nil];
    fontSize = 12.0;
    detailRect = [item.detailText boundingRectWithSize:CGSizeMake(bounds.size.width-10, MAXFLOAT)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                               context:nil];
    
    titleRect.size.width = bounds.size.width;
    titleRect.size.height += detailRect.size.height;
    
    //margins
    titleRect.size.height += 15;

    return titleRect.size;
}
@end
