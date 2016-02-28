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
@property (strong,nonatomic)UICollectionViewLayout* selectedLayout;
@end

#define gridCellReuseID @"gridCollectionViewCell"
#define listCellReuseID @"listCollectionViewCell"

typedef NS_ENUM(NSInteger, AAACollectionViewGridListSection){
    AAACollectionViewGridListSectionFirst
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
    [super viewDidLayoutSubviews];
    //We do this to make it easy to change the margins
    self.view.layoutMargins = UIEdgeInsetsMake(0,0,0,0);
}

- (IBAction)gridButtonTapped:(UIButton *)sender {
    self.selectedLayout = [[AAAGridFlowLayout alloc]init];
    [self selectLayout];
    [self.collectionView reloadData];
    
}
- (IBAction)listButtonTapped:(UIButton *)sender {
    self.selectedLayout = [[AAAListFlowLayout alloc]init];;
    [self selectLayout];
    [self.collectionView reloadData];
}

-(void)selectLayout{
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    //Uncomment to animate changing of layout
    //    [UIView animateWithDuration:1.0 animations:^(void){
    //      [self.collectionView setCollectionViewLayout:[[AAAGridFlowLayout alloc]init] animated:YES];
    //    }];
    [self.collectionView setCollectionViewLayout:self.selectedLayout animated:NO];
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
    if([self.selectedLayout isKindOfClass:[AAAGridFlowLayout class]]){
        newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:gridCellReuseID forIndexPath:indexPath];
        CollectionViewGridCell* gridCell = (CollectionViewGridCell*)newCell;
        gridCell.titleLabel.text = [NSString stringWithFormat:@"Item %ld",(long)indexPath.item];
    }else{
        newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:listCellReuseID forIndexPath:indexPath];
        CollectionViewListCell* listCell = (CollectionViewListCell*)newCell;
        listCell.titleLabel.text = [NSString stringWithFormat:@"Item %ld",(long)indexPath.item];
        listCell.detailLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
    }
    
    self.cellTemplate = newCell;
    
    return newCell;
}

@end
