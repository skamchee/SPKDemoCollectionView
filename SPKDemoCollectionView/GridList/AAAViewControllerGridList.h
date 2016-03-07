//
//  ViewController.h
//  SPKDemoCollectionView
//
//  Created by Spencer Kamchee on 2/24/16.
//  Copyright © 2016 Spencer Kamchee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAAModelItem.h"

@interface AAAViewControllerGridList : UIViewController <UICollectionViewDataSource>

-(AAAModelItem*)modelAtIndexPath:(NSIndexPath*)indexPath;
@property (strong,nonatomic)NSMutableArray<AAAModelItem*>* modelArray;

@end

