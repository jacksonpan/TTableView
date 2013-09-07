//
//  ViewCell.h
//  TTableViewExample
//
//  Created by ren pan on 13-9-7.
//  Copyright (c) 2013年 ren pan. All rights reserved.
//

#import "TIOS7GestureTableViewCell.h"

typedef void(^cellDelete)(id _cell);

@interface ViewCell : TIOS7GestureTableViewCell
@property (nonatomic, strong) cellDelete blockCellDelete;

- (void)setBlockCellDelete:(cellDelete)blockCellDelete;
- (void)setData:(id)data;
@end
