//
//  AACCustomFlowLayoutViewController.m
//  SPKDemoCollectionView
//
//  Created by Spencer Kamchee on 2/29/16.
//  Copyright © 2016 Spencer Kamchee. All rights reserved.
//

#import "AACCustomFlowLayoutViewController.h"
#import "AACCustomCollectionViewFlowLayout.h"
#import "CollectionViewListCell.h"

#define listCellReuseID @"listCollectionViewCell"

typedef NS_ENUM(NSInteger, AAACollectionViewGridListSection){
    AACCollectionViewSectionFirst
};

@interface AACCustomFlowLayoutViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation AACCustomFlowLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self populateModelObject];
    [self.collectionView setCollectionViewLayout:[[AACCustomCollectionViewFlowLayout alloc]init] animated:NO];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UINib* listNib = [UINib nibWithNibName:@"CollectionViewListCell" bundle:nil];
    [self.collectionView registerNib:listNib forCellWithReuseIdentifier:listCellReuseID];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //We do this to make it easy to change the margins
    self.view.layoutMargins = UIEdgeInsetsMake(0,5,5,5);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == AACCollectionViewSectionFirst){
        return [[self modelArray]count];
    }
    return 0;
}

-(UICollectionViewCell*)configureCell:(UICollectionViewCell*)cell forIndexPath:(NSIndexPath*)indexPath{
        CollectionViewListCell* listCell = (CollectionViewListCell*)cell;
        listCell.titleLabel.text = [(AAAModelItem*)[[self modelArray]objectAtIndex:indexPath.item] title];
        listCell.detailLabel.text = [(AAAModelItem*)[[self modelArray]objectAtIndex:indexPath.item] detailText];
        //set the width so multi-line label doesn't shrink when auto layout redraws it
        //TODO: THIS IS CHANGED WHEN CHANGING SIZE OF COLLECTION VIEW
        listCell.titleLabel.preferredMaxLayoutWidth = self.collectionView.bounds.size.width/4-10;
        listCell.detailLabel.preferredMaxLayoutWidth = self.collectionView.bounds.size.width/4-10;
        return listCell;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* newCell;
    newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:listCellReuseID forIndexPath:indexPath];
    newCell = [self configureCell:newCell forIndexPath:indexPath];
    
    return newCell;
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
