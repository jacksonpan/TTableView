//
//  TIOS7TableViewCell.h
//  t2u
//
//  Created by ren pan on 13-7-5.
//  Copyright (c) 2013年 ren pan. All rights reserved.
//

#import "TTableViewCell.h"

@interface TContentViewCell : UIView

@end

@interface TIOS7TableViewCell : TTableViewCell

@property (nonatomic, strong) TContentViewCell* tContentView;

@property (nonatomic, assign) BOOL islastCell;
@property (nonatomic, assign) BOOL isFirstCell;
@property (nonatomic, strong) NSIndexPath* indexPath;
@property (nonatomic, assign) CGFloat lineStartOffsetX;

- (void)initContent;

//you must check cell first
- (void)checkCellWithIndexPath:(NSIndexPath*)indexPath tableView:(UITableView*)tableView;

- (void)drawCell:(CGRect)rect;

@end
