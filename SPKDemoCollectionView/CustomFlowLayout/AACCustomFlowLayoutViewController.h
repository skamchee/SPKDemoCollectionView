//
//  AACCustomFlowLayoutViewController.h
//  SPKDemoCollectionView
//
//  Created by Spencer Kamchee on 2/29/16.
//  Copyright © 2016 Spencer Kamchee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAAModelItem.h"

@interface AACCustomFlowLayoutViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

-(AAAModelItem*)modelAtIndexPath:(NSIndexPath*)indexPath;
@property (strong,nonatomic)NSMutableArray<AAAModelItem*>* modelArray;

@end
