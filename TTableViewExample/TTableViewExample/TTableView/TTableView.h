//
//  TTableView.h
//  MicroTransfer
//
//  Created by jacksonpan on 13-1-19.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTableView_Define.h"
#import "TTableView+Transform.h"
#import "TTableViewCell.h"

#define MSG_TTableView_ReloadData_END          @"MSG_TTableView_ReloadData_END"

@interface TTableView : UITableView
#pragma mark - DataSource @required
@property (nonatomic, strong) numberOfRows blockNumberOfRows;
@property (nonatomic, strong) cellForRowAtIndexPath blockCellForRowAtIndexPath;
#pragma mark - DataSource @optional
@property (nonatomic, strong) numberOfSections blockNumberOfSections;
@property (nonatomic, strong) titleForHeaderInSection blockTitleForHeaderInSection;
@property (nonatomic, strong) titleForFooterInSection blockTitleForFooterInSection;
@property (nonatomic, strong) canEditRowAtIndexPath blockCanEditRowAtIndexPath;
@property (nonatomic, strong) canMoveRowAtIndexPath blockCanMoveRowAtIndexPath;
@property (nonatomic, strong) sectionIndexTitles blockSectionIndexTitles;
@property (nonatomic, strong) sectionForSectionIndexTitle blockSectionForSectionIndexTitle;
@property (nonatomic, strong) commitEditingStyle blockCommitEditingStyle;
@property (nonatomic, strong) moveRowAtIndexPath blockMoveRowAtIndexPath;

#pragma mark - Delegate @optional
@property (nonatomic, strong) willDisplayCell blockwWllDisplayCell;
@property (nonatomic, strong) heightForRowAtIndexPath blockHeightForRowAtIndexPath;
@property (nonatomic, strong) heightForHeaderInSection blockHeightForHeaderInSection;
@property (nonatomic, strong) heightForFooterInSection blockHeightForFooterInSection;
@property (nonatomic, strong) viewForHeaderInSection blockViewForHeaderInSection;
@property (nonatomic, strong) viewForFooterInSection blockViewForFooterInSection;
@property (nonatomic, strong) accessoryButtonTappedForRowWithIndexPath blockAccessoryButtonTappedForRowWithIndexPath;
@property (nonatomic, strong) willSelectRowAtIndexPath blockWillSelectRowAtIndexPath;
@property (nonatomic, strong) willDeselectRowAtIndexPath blockWillDeselectRowAtIndexPath;
@property (nonatomic, strong) didSelectRowAtIndexPath blockDidSelectRowAtIndexPath;
@property (nonatomic, strong) didDeselectRowAtIndexPath blockDidDeselectRowAtIndexPath;
@property (nonatomic, strong) editingStyleForRowAtIndexPath blockEditingStyleForRowAtIndexPath;
@property (nonatomic, strong) titleForDeleteConfirmationButtonForRowAtIndexPath blockTitleForDeleteConfirmationButtonForRowAtIndexPath;
@property (nonatomic, strong) shouldIndentWhileEditingRowAtIndexPath blockShouldIndentWhileEditingRowAtIndexPath;
@property (nonatomic, strong) willBeginEditingRowAtIndexPath blockWillBeginEditingRowAtIndexPath;
@property (nonatomic, strong) didEndEditingRowAtIndexPath blockDidEndEditingRowAtIndexPath;
@property (nonatomic, strong) targetIndexPathForMoveFromRowAtIndexPath blockTargetIndexPathForMoveFromRowAtIndexPath;
@property (nonatomic, strong) indentationLevelForRowAtIndexPath blockIndentationLevelForRowAtIndexPath;
@property (nonatomic, strong) shouldShowMenuForRowAtIndexPath blockShouldShowMenuForRowAtIndexPath;
@property (nonatomic, strong) canPerformAction blockCanPerformAction;
@property (nonatomic, strong) performAction blockPerformAction;

@property (nonatomic, strong) TTableViewReloadStart blockTTableViewReloadStart;
@property (nonatomic, strong) TTableViewReloadEnd blockTTableViewReloadEnd;
@property (nonatomic, strong) TTableViewReloadAndDisplayEnd blockTTableViewReloadAndDisplayEnd;

@property (nonatomic, strong) scrollViewDidScroll blockScrollViewDidScroll;

- (void)setBlockNumberOfSections:(numberOfSections)blockNumberOfSections;
- (void)setBlockSectionForSectionIndexTitle:(sectionForSectionIndexTitle)blockSectionForSectionIndexTitle;
- (void)setBlockNumberOfRows:(numberOfRows)blockNumberOfRows;
- (void)setBlockCellForRowAtIndexPath:(cellForRowAtIndexPath)blockCellForRowAtIndexPath;
- (void)setBlockHeightForHeaderInSection:(heightForHeaderInSection)blockHeightForHeaderInSection;
- (void)setBlockHeightForRowAtIndexPath:(heightForRowAtIndexPath)blockHeightForRowAtIndexPath;
- (void)setBlockDidSelectRowAtIndexPath:(didSelectRowAtIndexPath)blockDidSelectRowAtIndexPath;
- (void)setBlockViewForHeaderInSection:(viewForHeaderInSection)blockViewForHeaderInSection;
- (void)setBlockEditingStyleForRowAtIndexPath:(editingStyleForRowAtIndexPath)blockEditingStyleForRowAtIndexPath;
- (void)setBlockCommitEditingStyle:(commitEditingStyle)blockCommitEditingStyle;
- (void)setBlockCanEditRowAtIndexPath:(canEditRowAtIndexPath)blockCanEditRowAtIndexPath;
- (void)setBlockTTableViewReloadStart:(TTableViewReloadStart)blockTTableViewReloadStart;
- (void)setBlockTTableViewReloadEnd:(TTableViewReloadEnd)blockTTableViewReloadEnd;
- (void)setBlockTTableViewReloadAndDisplayEnd:(TTableViewReloadAndDisplayEnd)blockTTableViewReloadAndDisplayEnd;
- (void)setBlockTitleForHeaderInSection:(titleForHeaderInSection)blockTitleForHeaderInSection;
- (void)setBlockDidDeselectRowAtIndexPath:(didDeselectRowAtIndexPath)blockDidDeselectRowAtIndexPath;
- (void)setBlockScrollViewDidScroll:(scrollViewDidScroll)blockScrollViewDidScroll;
/* block above */

@property (nonatomic, assign) BOOL enableTransform;
@property (nonatomic, strong) TTableViewCellTransform blockTransform;
@property (nonatomic, assign) BOOL enableIOS7Style;
- (CGPoint)scrollSpeed;
- (void)setBlockTransform:(TTableViewCellTransform)blockTransform;
@end
