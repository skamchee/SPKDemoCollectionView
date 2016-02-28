//
//  AABViewControllerSupplementaryView.m
//  SPKDemoCollectionView
//
//  Created by Spencer Kamchee on 2/25/16.
//  Copyright © 2016 Spencer Kamchee. All rights reserved.
//

#import "AABViewControllerSupplementaryView.h"

@interface AABViewControllerSupplementaryView ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

#define gridCellReuseID @"gridCollectionViewCell"
#define listCellReuseID @"listCollectionViewCell"

typedef NS_ENUM(NSInteger, AABCollectionViewGridListSection){
    AABCollectionViewGridListSectionFirst,
    AABCollectionViewGridListSectionSecond
};

@implementation AABViewControllerSupplementaryView


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.collectionView.dataSource = self;
    
    UINib* gridNib = [UINib nibWithNibName:@"CollectionViewGridCell" bundle:nil];
    [self.collectionView registerNib:gridNib forCellWithReuseIdentifier:gridCellReuseID];
    
    UINib* listNib = [UINib nibWithNibName:@"CollectionViewListCell" bundle:nil];
    [self.collectionView registerNib:listNib forCellWithReuseIdentifier:listCellReuseID];
    
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableHeader"];
//        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"reusableFooter"];
}


-(void)viewDidLayoutSubviews{
    //We do this to make it easy to change the margins
    self.view.layoutMargins = UIEdgeInsetsMake(0,0,0,0);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == AABCollectionViewGridListSectionFirst){
        return 100;
    }else if(section == AABCollectionViewGridListSectionSecond){
        return 50;
    }
    return 0;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* newCell;
    newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:gridCellReuseID forIndexPath:indexPath];

    // newCell. = [NSString stringWithFormat:@"Section:%ld, Item:%ld",(long)indexPath.section, (long)indexPath.item];
    return newCell;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView* suppView;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        suppView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"reusableHeader" forIndexPath:indexPath];
    }else{
        suppView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"reusableFooter" forIndexPath:indexPath];
    }
    //
//    if(indexPath.section == AABCollectionViewGridListSectionFirst){
//        
//    }
    
    return suppView;
}

@end
