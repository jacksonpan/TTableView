//
//  TTableView_Define.h
//  MicroTransfer
//
//  Created by jacksonpan on 13-1-28.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "TTableView.h"

@class TTableView;

//DataSource
typedef NSInteger(^numberOfRows)(TTableView *tableView, NSInteger section);
typedef UITableViewCell*(^cellForRowAtIndexPath)(TTableView *tableView, NSIndexPath *indexPath);
typedef NSInteger(^numberOfSections)(TTableView *tableView);
typedef NSString*(^titleForHeaderInSection)(TTableView *tableView, NSInteger section);
typedef NSString*(^titleForFooterInSection)(TTableView *tableView, NSInteger section);
typedef BOOL(^canEditRowAtIndexPath)(TTableView *tableView, NSIndexPath *indexPath);
typedef BOOL(^canMoveRowAtIndexPath)(TTableView *tableView, NSIndexPath *indexPath);
typedef NSArray*(^sectionIndexTitles)(TTableView* tableView);
typedef NSInteger(^sectionForSectionIndexTitle)(TTableView *tableView, NSString *title, NSInteger index);
typedef void(^commitEditingStyle)(TTableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath);
typedef void(^moveRowAtIndexPath)(TTableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
//Delegate
typedef void(^willDisplayCell)(TTableView* tableView, UITableViewCell* cell, NSIndexPath* indexPath);
typedef CGFloat(^heightForRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef CGFloat(^heightForHeaderInSection)(TTableView* tableView, NSInteger section);
typedef CGFloat(^heightForFooterInSection)(TTableView* tableView, NSInteger section);
typedef UIView*(^viewForHeaderInSection)(TTableView* tableView, NSInteger section);
typedef UIView*(^viewForFooterInSection)(TTableView* tableView, NSInteger section);
typedef void(^accessoryButtonTappedForRowWithIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef NSIndexPath*(^willSelectRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef NSIndexPath*(^willDeselectRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef void(^didSelectRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef void(^didDeselectRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef UITableViewCellEditingStyle(^editingStyleForRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef NSString*(^titleForDeleteConfirmationButtonForRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef BOOL(^shouldIndentWhileEditingRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef void(^willBeginEditingRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef void(^didEndEditingRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef NSIndexPath*(^targetIndexPathForMoveFromRowAtIndexPath)(TTableView* tableView, NSIndexPath* sourceIndexPath, NSIndexPath* proposedDestinationIndexPath);
typedef NSInteger(^indentationLevelForRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef BOOL(^shouldShowMenuForRowAtIndexPath)(TTableView* tableView, NSIndexPath* indexPath);
typedef BOOL(^canPerformAction)(TTableView* tableView, SEL canPerformAction, NSIndexPath* forRowAtIndexPath, id withSender);
typedef void(^performAction)(TTableView* tableView, SEL performAction, NSIndexPath* forRowAtIndexPath, id withSender);

/* block above */
typedef NSTimeInterval (^TTableViewCellTransform)(CALayer * layer, float speed);

/* block msg */
typedef void (^TTableViewReloadStart)(TTableView* tableView);
typedef void (^TTableViewReloadEnd)(TTableView* tableView);
typedef void (^TTableViewReloadAndDisplayEnd)(TTableView* tableView);

typedef void (^scrollViewDidScroll)(UIScrollView *scrollView);