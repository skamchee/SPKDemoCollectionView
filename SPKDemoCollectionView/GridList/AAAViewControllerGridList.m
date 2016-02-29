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
    
    [self populateModelObject];
    [self gridButtonTapped:nil];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

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

//Unfortunately, this method appears to be called before cellForItemAtIndexPath
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if([collectionViewLayout isKindOfClass:[AAAListFlowLayout class]]){
//        if([self.cellTemplate isKindOfClass:[CollectionViewListCell class]]){
//            CGSize size = [self.cellTemplate intrinsicContentSize];
//            return size;
//        }
//    }
//    return [(UICollectionViewFlowLayout*)collectionViewLayout itemSize];
//
//
//}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == AAACollectionViewGridListSectionFirst){
        return [[self modelArray]count];
    }
    return 0;
}

-(UICollectionViewCell*)configureCell:(UICollectionViewCell*)cell forIndexPath:(NSIndexPath*)indexPath{
    if([self.selectedLayout isKindOfClass:[AAAGridFlowLayout class]]){
        CollectionViewGridCell* gridCell = (CollectionViewGridCell*)cell;
        gridCell.titleLabel.text = [(AAAModelItem*)[[self modelArray]objectAtIndex:indexPath.item] title];
        return gridCell;
    }else{
        CollectionViewListCell* listCell = (CollectionViewListCell*)cell;
        listCell.titleLabel.text = [(AAAModelItem*)[[self modelArray]objectAtIndex:indexPath.item] title];
        listCell.detailLabel.text = [(AAAModelItem*)[[self modelArray]objectAtIndex:indexPath.item] detailText];
        //set the width so multi-line label doesn't shrink when auto layout redraws it
        //TODO: THIS IS CHANGED WHEN CHANGING SIZE OF COLLECTION VIEW
        listCell.titleLabel.preferredMaxLayoutWidth = self.collectionView.bounds.size.width/4-10;
        listCell.detailLabel.preferredMaxLayoutWidth = self.collectionView.bounds.size.width/4-10;
        return listCell;
    }
}



-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* newCell;
    if([self.selectedLayout isKindOfClass:[AAAGridFlowLayout class]]){
        newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:gridCellReuseID forIndexPath:indexPath];
        
    }else{
        newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:listCellReuseID forIndexPath:indexPath];
    }
    
    newCell = [self configureCell:newCell forIndexPath:indexPath];
    
    return newCell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UICollectionViewCell* newCell;
        newCell = [self configureCell:newCell forIndexPath:indexPath];
    return [newCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

#pragma mark - Model 

-(AAAModelItem*)modelAtIndexPath:(NSIndexPath*)indexPath{
    return [self.modelArray objectAtIndex:indexPath.item];
}

-(void)populateModelObject{
    NSString* sentence = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in ";
    NSArray* wordsArray = [sentence componentsSeparatedByString:@" "];
    NSMutableArray<AAAModelItem*>* modelArray= [[NSMutableArray alloc]init];
    for(int i=0; i<20; i++){
        AAAModelItem* modelItem = [[AAAModelItem alloc]init];
        modelItem.title = [NSString stringWithFormat:@"Item %d",i];

        NSMutableString * result = [[NSMutableString alloc] init];
        for (int j=0;j<i+1;j++)
        {
            [result appendString:[wordsArray objectAtIndex:j]];
            [result appendString:@" "];
        }
        NSLog(@"The concatenated string is %@", result);
        
        modelItem.detailText = result;
        [modelArray addObject:modelItem];
    }
    self.modelArray = modelArray;
}
@end
