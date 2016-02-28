//
//  ViewController.m
//  SPKDemoCollectionView
//
//  Created by Spencer Kamchee on 2/24/16.
//  Copyright © 2016 Spencer Kamchee. All rights reserved.
//

#import "AAAViewControllerGridList.h"
#import "AAAGridFlowLayout.h"
#import "AAAListFlowLayout.h"
#import "CollectionViewGridCell.h"
#import "CollectionViewListCell.h"

@interface AAAViewControllerGridList ()
@property (weak, nonatomic) IBOutlet UIButton *gridButton;
@property (weak, nonatomic) IBOutlet UIButton *listButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign)NSInteger selectedLayout;
@end

#define gridCellReuseID @"gridCollectionViewCell"
#define listCellReuseID @"listCollectionViewCell"

typedef NS_ENUM(NSInteger, AAACollectionViewGridListSection){
    AAACollectionViewGridListSectionFirst
};

typedef NS_ENUM(NSInteger, AAACollectionViewLayoutSelected){
    AAACollectionViewLayoutSelectedGrid,
    AAACollectionViewLayoutSelectedList
};

@implementation AAAViewControllerGridList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.selectedLayout = AAACollectionViewLayoutSelectedGrid;
    self.collectionView.dataSource = self;

    UINib* gridNib = [UINib nibWithNibName:@"CollectionViewGridCell" bundle:nil];
    [self.collectionView registerNib:gridNib forCellWithReuseIdentifier:gridCellReuseID];
    
    UINib* listNib = [UINib nibWithNibName:@"CollectionViewListCell" bundle:nil];
    [self.collectionView registerNib:listNib forCellWithReuseIdentifier:listCellReuseID];
}


-(void)viewDidLayoutSubviews{
    //We do this to make it easy to change the margins
    self.view.layoutMargins = UIEdgeInsetsMake(0,0,0,0);
}

- (IBAction)gridButtonTapped:(UIButton *)sender {
    self.selectedLayout = AAACollectionViewLayoutSelectedGrid;
    
    [self.collectionView.collectionViewLayout invalidateLayout];

//Uncomment to animate changing of layout
//    [UIView animateWithDuration:1.0 animations:^(void){
//      [self.collectionView setCollectionViewLayout:[[AAAGridFlowLayout alloc]init] animated:YES];
//    }];
    
    [self.collectionView setCollectionViewLayout:[[AAAGridFlowLayout alloc]init] animated:NO];
    
    [self.collectionView reloadData];
    
}
- (IBAction)listButtonTapped:(UIButton *)sender {
    self.selectedLayout = AAACollectionViewLayoutSelectedList;
    [self.collectionView.collectionViewLayout invalidateLayout];

//Uncomment to animate changing of layout
//    [UIView animateWithDuration:1.0 animations:^(void){
//        [self.collectionView setCollectionViewLayout:[[AAAListFlowLayout alloc]init] animated:YES];
//    }];
    
    [self.collectionView setCollectionViewLayout:[[AAAListFlowLayout alloc]init] animated:NO];
    
    [self.collectionView reloadData];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == AAACollectionViewGridListSectionFirst){
        return 10;
    }
    return 0;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* newCell;
    if(self.selectedLayout == AAACollectionViewLayoutSelectedGrid){
        newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:gridCellReuseID forIndexPath:indexPath];
        CollectionViewGridCell* gridCell = (CollectionViewGridCell*)newCell;
        gridCell.titleLabel.text = [NSString stringWithFormat:@"Item:%ld",(long)indexPath.item];
    }else{
        newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:listCellReuseID forIndexPath:indexPath];
        CollectionViewListCell* gridCell = (CollectionViewListCell*)newCell;
        gridCell.titleLabel.text = [NSString stringWithFormat:@"Item:%ld",(long)indexPath.item];
    }
    
    return newCell;
}

@end
