//
//  CollectionViewListCell.h
//  SPKDemoCollectionView
//
//  Created by Spencer Kamchee on 2/25/16.
//  Copyright © 2016 Spencer Kamchee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
