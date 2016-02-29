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

//i.e. don't recalculate the layout simply because the user scrolled i.e. the rect origin changes
//this should return YES if you make it possible to change the size of the rect.
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return NO;
}

//1. prepare the layout information
-(void)prepareLayout{
    [super prepareLayout];
    self.layoutAttributes = [NSMutableArray array];
    NSArray *allIndexPaths = [self allIndexPaths];
    for (NSIndexPath *indexPath in allIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = [self frameForItemAtIndexPath:indexPath];
        [self.layoutAttributes addObject:attributes];
    }
}

-(CGRect)frameForItemAtIndexPath:(NSIndexPath*)indexPath{
    AAAViewControllerGridList* dataSource = (AAAViewControllerGridList*)self.collectionView.dataSource;
    AAAModelItem* item = [dataSource modelAtIndexPath:indexPath];
    
    //TODO: THIS IS CHANGED WHEN CHANGING SIZE OF COLLECTION VIEW
    CGRect bounds = CGRectMake(0,0,self.collectionView.bounds.size.width/4,self.collectionView.bounds.size.height);
    
    CGFloat fontSize = 17.0;
    

    CGRect titleSize = [item.title boundingRectWithSize:CGSizeMake(bounds.size.width-10, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                                context:nil];
    fontSize = 12.0;
    CGRect detailSize = [item.detailText boundingRectWithSize:CGSizeMake(bounds.size.width-10, MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                                      context:nil];

    //should actually pick the max of the two
//    titleSize.size.width += detailSize.size.width;
    if(titleSize.size.width < detailSize.size.width){
        titleSize.size.width = detailSize.size.width;
    }
    
    titleSize.size.height += detailSize.size.height;
    
    //add margins
    titleSize.size.width += 10;
    titleSize.size.height += 15;
    
    //layout the next cells x and y
    if(indexPath.item != 0){
        UICollectionViewLayoutAttributes* previous = [self.layoutAttributes objectAtIndex:indexPath.item-1];
        titleSize.origin.x = previous.frame.origin.x + previous.frame.size.width + 20;
        titleSize.origin.y = previous.frame.origin.y + previous.frame.size.height + 20;
    }
    
    return titleSize;
}

-(NSArray*)allIndexPaths{
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

//2. Set the content size based on what we found out in prepareLayout
-(CGSize)collectionViewContentSize{
    //assuming last object is farthest vertically and horizontally from origin of collectionview frame
    UICollectionViewLayoutAttributes* last = [self.layoutAttributes lastObject];
    return CGSizeMake(last.frame.origin.x + last.frame.size.width, last.frame.origin.y + last.frame.size.height);
}

//3. Respond to ad-hoc requests for layouts
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
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
    
    //new implementation should look through all items in self.layoutattributes, check if the rect is wiihing the rect given. if it is, add it to the array, else dont bother.
    
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



//Logic for how to layout the cells
-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.layoutAttributes objectAtIndex:indexPath.item];
}





@end
