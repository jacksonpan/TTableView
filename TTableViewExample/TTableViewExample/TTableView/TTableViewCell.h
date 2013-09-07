//
//  TTableViewCell.h
//  MicroTransfer
//
//  Created by jacksonpan on 13-1-15.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTableViewCell : UITableViewCell
- (void)initCell;
@end

@interface UITableViewCell (TTableViewCell)
+ (NSString*)getSelfName;
+ (id)loadReuseableNib:(UITableView*)tableView;
+ (id)loadReuseableNoNib:(UITableView*)tableView style:(UITableViewCellStyle)style;
+ (id)loadReuseableFromStoryboard:(UITableView*)tableView;
@end