//
//  TIOS7GestureTableViewCell.h
//  t2u
//
//  Created by ren pan on 13-7-18.
//  Copyright (c) 2013年 ren pan. All rights reserved.
//

#import "TGestureTableViewCell.h"

@interface TIOS7GestureTableViewCell : TGestureTableViewCell
@property (nonatomic, assign) BOOL islastCell;
@property (nonatomic, assign) BOOL isFirstCell;
@property (nonatomic, strong) NSIndexPath* indexPath;
@property (nonatomic, assign) CGFloat lineStartOffsetX;

- (void)initForSubClass;

- (void)checkCellWithIndexPath:(NSIndexPath*)indexPath tableView:(UITableView*)tableView;

@end
