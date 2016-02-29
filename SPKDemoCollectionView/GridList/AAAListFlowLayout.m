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

//-(CGFloat)itemHeight{
//    return 10;
//}
//
//-(CGFloat)itemWidth{
//    return CGRectGetWidth(self.collectionView.frame);
//}
//
////This size is used if the collection view does not implement collectionView:layout:sizeForItemAtIndexPath:
//-(CGSize)itemSize{
//    return CGSizeMake([self itemWidth],[self itemHeight]);
//}
//
//-(void)setItemSize{
//    self.itemSize = CGSizeMake([self itemWidth],[self itemHeight]);
//}
//
//-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
//    return self.collectionView.contentOffset;
//}



-(void)prepareLayout{
    [super prepareLayout];
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    self.layoutAttributes = [NSMutableArray array];
    
    // Cells
    // We call a custom helper method -indexPathsOfItemsInRect: here
    // which computes the index paths of the cells that should be included
    // in rect.
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.layoutAttributes addObject:attributes];
    }
    return self.layoutAttributes;
}

-(NSArray*)indexPathsOfItemsInRect:(CGRect)rect{
    AAAViewControllerGridList* dataSource = (AAAViewControllerGridList*)self.collectionView.dataSource;
    NSMutableArray* array = [[NSMutableArray alloc]init];
    int i =0;
    for(id item in [dataSource modelArray]){
        //TODO: dont hardcode the section
        NSIndexPath* path = [NSIndexPath indexPathForItem:i inSection:0];
        
        [array addObject:path];
        i++;
    }
    return array;
}

-(CGSize)collectionViewContentSize{
    //assuming last object is farthest vertically and horizontally from origin of collectionview frame
    UICollectionViewLayoutAttributes* last = [self.layoutAttributes lastObject];
    return CGSizeMake(last.frame.origin.x + last.frame.size.width, last.frame.origin.y + last.frame.size.height);
}

//Logic for how to layout the cells
-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{


    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [self frameForItemAtIndexPath:indexPath];
    return attributes;
}

-(CGRect)frameForItemAtIndexPath:(NSIndexPath*)indexPath{
    AAAViewControllerGridList* dataSource = (AAAViewControllerGridList*)self.collectionView.dataSource;
    AAAModelItem* item = [dataSource modelAtIndexPath:indexPath];
    
    CGRect bounds = self.collectionView.bounds;
    
    CGFloat fontSize = 17.0;
    CGRect titleSize = [item.title boundingRectWithSize:CGSizeMake(bounds.size.width-100, MAXFLOAT)
                       options:NSStringDrawingUsesLineFragmentOrigin
                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                       context:nil];
    fontSize = 12.0;
    CGRect detailSize = [item.detailText boundingRectWithSize:CGSizeMake(bounds.size.width-100, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                                context:nil];
    
    titleSize.size.width += detailSize.size.width;
    titleSize.size.height += detailSize.size.height;
    
    if(indexPath.item != 0){
        UICollectionViewLayoutAttributes* previous = [self.layoutAttributes objectAtIndex:indexPath.item-1];
        titleSize.origin.x = 0;
        titleSize.origin.y = previous.frame.origin.y + previous.frame.size.height + 20;
    }

    return titleSize;
}



@end
